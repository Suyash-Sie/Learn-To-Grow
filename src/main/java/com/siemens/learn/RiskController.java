package com.siemens.learn;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.siemens.learn.model.Risk;
import com.siemens.learn.service.DBService;
import com.siemens.learn.service.RiskService;

@Controller
public class RiskController 
{
	private DBService dbService;
	private RiskService riskService;
	private Risk currentRisks;
	
	public RiskController()
	{
		dbService = new DBService();
		riskService = new RiskService(dbService);
	}
	
	@RequestMapping(value = "/userscreen_admin", method = RequestMethod.GET)
	public ModelAndView riskInit(ModelAndView model) 
	{
		try
		{
			currentRisks = riskService.getAllRisks();
			model.addObject("risk", currentRisks);
			model.setViewName("userscreen_admin");
			int currentMonth = Calendar.getInstance().get(Calendar.MONTH);
			if(currentMonth > 9)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "false");
				model.addObject("checkq3", "false");
				model.addObject("checkq4", "false");
			}
			else if(currentMonth < 4)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "false");
				model.addObject("checkq4", "false");
			}
			else if(currentMonth < 7)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "true");
				model.addObject("checkq4", "false");
			}
			else if(currentMonth < 10)
			{
				model.addObject("checkq1", "true");
				model.addObject("checkq2", "true");
				model.addObject("checkq3", "true");
				model.addObject("checkq4", "true");
			}
		}
		catch(Exception e)
		{
			
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
			newRisk = riskService.calculateNewRisk(currentRisks, groupNames, quarters);
		}
		catch(Exception e)
		{
			
		}
		model.addAttribute("risk", newRisk);
		ObjectMapper mapper = new ObjectMapper();
		
		String jsonInString = "";
		try 
		{
			jsonInString = mapper.writeValueAsString(newRisk);
		} 
		catch (JsonProcessingException e) 
		{
			e.printStackTrace();
		}
		return jsonInString;
	}
}