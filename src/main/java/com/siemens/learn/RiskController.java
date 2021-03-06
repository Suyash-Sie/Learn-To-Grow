package com.siemens.learn;

import java.awt.Color;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.siemens.learn.model.Risk;
import com.siemens.learn.model.Target;
import com.siemens.learn.service.DBService;
import com.siemens.learn.service.RiskService;
import com.siemens.learn.service.TargetService;

@Controller
public class RiskController 
{
	private DBService dbService;
	private RiskService riskService;
	private Risk currentRisks;
	private List<String> selectedGroups;
	private List<String> selectedQuarters;
	private TargetService targetService;
	
	public RiskController()
	{
		selectedGroups = new ArrayList<>();
		dbService = new DBService();
		riskService = new RiskService(dbService);
		targetService = new TargetService(dbService);
	}
	
	@RequestMapping(value = "/userscreen_admin", method = RequestMethod.GET)
	public ModelAndView riskInit(ModelAndView model, @ModelAttribute("user") String user) 
	{
		try
		{
			if(null == user || user.isEmpty())
			{
				model.setViewName("hello");
				return model;
			}
			currentRisks = riskService.getAllRisks();
			selectedGroups = Arrays.asList("R7","R8","SIT","SYSTEC","TDOC","PRM","TE");
			model.addObject("risk", currentRisks);
			model.addObject("user", user);
			model.setViewName("userscreen_admin");
			int currentMonth = Calendar.getInstance().get(Calendar.MONTH);
			if(currentMonth > 9)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "false");
				model.addObject("checkq3", "false");
				model.addObject("checkq4", "false");
				selectedQuarters = Arrays.asList("Quarter 1");
			}
			else if(currentMonth < 4)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "false");
				model.addObject("checkq4", "false");
				selectedQuarters = Arrays.asList("Quarter 1", "Quarter 2");
			}
			else if(currentMonth < 7)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "true");
				model.addObject("checkq4", "false");
				selectedQuarters = Arrays.asList("Quarter 1", "Quarter 2", "Quarter 3");
			}
			else if(currentMonth < 10)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "true");
				model.addObject("checkq4", "true");
				selectedQuarters = Arrays.asList("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4");
			}
		}
		catch(Exception e)
		{
			model.setViewName("hello");
		}
		return model;
	}
	
	@RequestMapping(value = "/checkbox", method = RequestMethod.GET)
	@ResponseBody
	public String newRisk(Model model, HttpServletRequest req) 
	{
		Risk newRisk = new Risk();
		try
		{
			String checkSelected = req.getParameter("checked");
			String quarterSelected = req.getParameter("quarter");
			List<String> groupNames = new ArrayList<>();
			String[] groupSplit = checkSelected.split("\\.");
			for (String group : groupSplit) 
			{
				if(group.contains("true"))
					groupNames.add(group.split(";")[0]);
			}
			List<String> quarters = new ArrayList<>();
			String[] quarterSplit = quarterSelected.split("\\.");
			for (String quarter : quarterSplit) 
			{
				if(quarter.contains("true"))
					quarters.add(quarter.split(";")[0]);
			}
			selectedQuarters = new ArrayList<>();
			if(quarters.contains("Q1"))
				selectedQuarters.add("Quarter 1");
			if(quarters.contains("Q2"))
				selectedQuarters.add("Quarter 2");
			if(quarters.contains("Q3"))
				selectedQuarters.add("Quarter 3");
			if(quarters.contains("Q4"))
				selectedQuarters.add("Quarter 4");
			selectedGroups = groupNames;
			newRisk = riskService.calculateNewRisk(currentRisks, groupNames, quarters);
			model.addAttribute("risk", newRisk);
			ObjectMapper mapper = new ObjectMapper();
			
			return mapper.writeValueAsString(newRisk);
		}
		catch(Exception e)
		{
			return "hello";
		}
	}
	
	/**
     * Handle request to download an Excel document
	 * @throws Exception 
     */
    @RequestMapping(value = "/downloadExcel", method = RequestMethod.GET)
    public @ResponseBody void downloadExcel(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	XSSFWorkbook workbook = new XSSFWorkbook();
    	XSSFSheet sheet = workbook.createSheet();
    	XSSFCellStyle xssfCellStyle = workbook.createCellStyle();
    	createHeaderRow(sheet);
    	System.out.println(request.getParameter("checked"));
    	System.out.println(request.getParameter("quarter"));
    	int rowNum = 1;

		for(String group : selectedGroups)
		{
			List<String> users = dbService.getUsersInGroup(group);
			for(String user : users)
			{
				int nameStartIndex = rowNum;
				String name = dbService.getName(user.toUpperCase());
//			String quarter = "Quarter 1";
				for(String quarter : selectedQuarters)
				{
					int quarterStartIndex = rowNum;
					List<Target> targetsForUser = targetService.getTargetsForUser(user, quarter);
					for(Target target : targetsForUser)
					{
						XSSFRow aRow = sheet.createRow(rowNum++);
						aRow.createCell(1).setCellValue(name);
				        //aRow.getCell(1).setCellStyle(cellStyle);
						sheet.autoSizeColumn(1);
						aRow.createCell(2).setCellValue(user);
						//aRow.getCell(2).setCellStyle(cellStyle);
						sheet.autoSizeColumn(2);
						aRow.createCell(3).setCellValue(group);
						//aRow.getCell(3).setCellStyle(cellStyle);
						sheet.autoSizeColumn(3);
						aRow.createCell(4).setCellValue(quarter);
						//aRow.getCell(4).setCellStyle(cellStyle);
						sheet.autoSizeColumn(4);
						aRow.createCell(5).setCellValue(target.getTargetName());
						//aRow.getCell(5).setCellStyle(cellStyle);
						sheet.autoSizeColumn(5);
						aRow.createCell(6).setCellValue(target.getCategory());
						//aRow.getCell(6).setCellStyle(cellStyle);
						sheet.autoSizeColumn(6);
						aRow.createCell(7).setCellValue(target.getLevel());
						//aRow.getCell(7).setCellStyle(cellStyle);
						sheet.autoSizeColumn(7);
						aRow.createCell(8).setCellValue(target.getCompletionPercent());
						//aRow.getCell(8).setCellStyle(cellStyle);
						sheet.autoSizeColumn(8);
						float riskForQuarter = Float.parseFloat(dbService.getRiskForQuarter(user.toUpperCase(), quarter));
						Color foregroundColor = new Color(255,0,0);
						if(riskForQuarter <= 100/3F)
							foregroundColor = new Color(160,215,44);
						else if(riskForQuarter <= 200/3F)
							foregroundColor = new Color(255,194,12);
						xssfCellStyle.setFillForegroundColor(new XSSFColor(foregroundColor));
						xssfCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
						xssfCellStyle.setBorderBottom(xssfCellStyle.BORDER_MEDIUM);
						xssfCellStyle.setBorderRight(xssfCellStyle.BORDER_MEDIUM);
						xssfCellStyle.setBorderTop(xssfCellStyle.BORDER_MEDIUM);
						aRow.createCell(9).setCellStyle(xssfCellStyle);
						sheet.autoSizeColumn(9);
					}
					if(rowNum - quarterStartIndex > 1)
					{
						int quarterEndIndex = rowNum - 1;						
						sheet.addMergedRegion(new CellRangeAddress(quarterStartIndex, quarterEndIndex, 4, 4));
						sheet.addMergedRegion(new CellRangeAddress(quarterStartIndex, quarterEndIndex, 9, 9));
					}
				}
				if(rowNum - nameStartIndex > 1)
				{
					int nameEndIndex = rowNum -1;
					CellRangeAddress rangeAddress = new CellRangeAddress(nameStartIndex, nameEndIndex, 1, 9);
					sheet.addMergedRegion(new CellRangeAddress(nameStartIndex, nameEndIndex, 1, 1));
					sheet.addMergedRegion(new CellRangeAddress(nameStartIndex, nameEndIndex, 2, 2));
					sheet.addMergedRegion(new CellRangeAddress(nameStartIndex, nameEndIndex, 3, 3));
                    RegionUtil.setBorderTop(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderRight(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderLeft(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderBottom(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
				}
				/*else
				{
				    CellRangeAddress rangeAddress = new CellRangeAddress(1, 1, 1, 9);
				    RegionUtil.setBorderTop(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderRight(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderLeft(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
                    RegionUtil.setBorderBottom(CellStyle.BORDER_MEDIUM, rangeAddress, sheet);
				}*/
			}
		}
	
    	response.setHeader("Content-disposition","attachment; filename=" + "LearnToGrow_Report.xlsx");
    	try {
    		workbook.write(response.getOutputStream());
    		workbook.close();
    	} catch (IOException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    }
    
    private void createHeaderRow(XSSFSheet sheet) {
		CellStyle cellStyle = sheet.getWorkbook().createCellStyle();
	    Font font = sheet.getWorkbook().createFont();
//	    font.setBold(true);
	    font.setColor(IndexedColors.WHITE.getIndex());
	    font.setFontHeightInPoints((short) 15);
	    font.setFontName("Cambria");
	    cellStyle.setFont(font);
	    cellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
	    cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
//	    cellStyle.setShrinkToFit(true);
	 
	    Row row = sheet.createRow(0);
//	    Cell cellSNo = row.createCell(0);
//	    cellSNo.setCellStyle(cellStyle);
//	    cellSNo.setCellValue("S.No.");

	    Cell cellName = row.createCell(1);
	    cellName.setCellStyle(cellStyle);
	    cellName.setCellValue("Name");
	 
	    Cell cellGid = row.createCell(2);
	    cellGid.setCellStyle(cellStyle);
	    cellGid.setCellValue("GID");
	 
	    Cell cellDept = row.createCell(3);
	    cellDept.setCellStyle(cellStyle);
	    cellDept.setCellValue("Dept.");
	    
	    Cell cellQuarter = row.createCell(4);
	    cellQuarter.setCellStyle(cellStyle);
	    cellQuarter.setCellValue("Quarter");
	    
	    Cell cellTarget = row.createCell(5);
	    cellTarget.setCellStyle(cellStyle);
	    cellTarget.setCellValue("Target");
	    
	    Cell cellCategory = row.createCell(6);
	    cellCategory.setCellStyle(cellStyle);
	    cellCategory.setCellValue("Category");
	    
	    Cell cellCompetency = row.createCell(7);
	    cellCompetency.setCellStyle(cellStyle);
	    cellCompetency.setCellValue("Competency");
	    
	    Cell cellCompletion = row.createCell(8);
	    cellCompletion.setCellStyle(cellStyle);
	    cellCompletion.setCellValue("Completion Perc");
	    
	    Cell cellRisk = row.createCell(9);
	    cellRisk.setCellStyle(cellStyle);
	    cellRisk.setCellValue("Learning Health Status");
	}
}