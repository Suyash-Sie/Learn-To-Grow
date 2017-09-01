package com.siemens.learn;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siemens.learn.model.Risk;
import com.siemens.learn.service.DBService;
import com.siemens.learn.service.RiskService;

@Controller
public class RiskController 
{
	private DBService dbService;
	private RiskService riskService;
	
	public RiskController()
	{
		dbService = new DBService();
		riskService = new RiskService(dbService);
	}
	
	@RequestMapping(value = "/userscreen_admin", method = RequestMethod.GET)
	public ModelAndView riskInit(ModelAndView model, @ModelAttribute("check") String check, @ModelAttribute("quarter") String quarter) 
	{
		try
		{
			Risk allRisks = riskService.getAllRisks();
			model.addObject("risk", allRisks);
			model.setViewName("userscreen_admin");
		}
		catch(Exception e)
		{
			
		}
		return model;
	}
	
	@RequestMapping(value = "/checkbox", method = RequestMethod.GET)
	@ResponseBody
	public String printHello(HttpServletRequest req) 
	{
		String newRisk = "";
		try
		{
			String checkSelected = req.getParameter("checked");
			List<String> groupNames = new ArrayList<>();
			String[] split = checkSelected.split("\\.");
			for (String group : split) 
			{
				if(group.contains("true"))
					groupNames.add(group.split(";")[0]);
			}
			newRisk = riskService.calculateNewRisk(groupNames);
		}
		catch(Exception e)
		{
			
		}
		return newRisk;
	}
}