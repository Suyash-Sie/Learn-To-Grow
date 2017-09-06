package com.siemens.learn.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.joda.time.DateTime;
import org.joda.time.Days;

import com.siemens.learn.model.Target;

public class TargetService 
{
	private DBService dbService;
	
	public TargetService(DBService dbService)
	{
		this.dbService = dbService;
	}
	
	public List<Target> getTargetsForUser(String gid, String quarter) throws Exception
	{
		List<Target> targets = new ArrayList<>();
		List<Map<String, String>> targetsFromDb = dbService.getTargets(gid, quarter);
		
		for (Map<String, String> map : targetsFromDb) 
		{
			Target target = new Target();
			for (Entry<String, String> entry : map.entrySet()) 
			{
				if(entry.getKey().equals("name"))
					target.setTargetName(entry.getValue());
				else if(entry.getKey().equals("category"))
					target.setCategory(entry.getValue());
				else if(entry.getKey().equals("level"))
					target.setLevel(entry.getValue());
				else if(entry.getKey().equals("completed"))
					target.setCompletionPercent(entry.getValue());
			}
			targets.add(target);
		}
		return targets;
	}
	
	public void submitTargets(String gid, List<Target> targets, String quarter) throws Exception
	{
		List<Map<String, String>> targetsToBeUpdated = new ArrayList<>();
		
		for (Target target : targets) 
		{
			Map<String, String> targetDetails = new HashMap<>();
			targetDetails.put("name", target.getTargetName());
			targetDetails.put("category", target.getCategory());
			targetDetails.put("level", target.getLevel());
			targetDetails.put("completed", target.getCompletionPercent());
			targetDetails.put("year", target.getYear());
			
			targetsToBeUpdated.add(targetDetails);
		}
		
		String risk = calculateRisk(targetsToBeUpdated, quarter);
		dbService.updateTargets(gid, new ArrayList<>(), "0", quarter);
		dbService.updateTargets(gid, targetsToBeUpdated, risk, quarter);
	}

	private String calculateRisk(List<Map<String, String>> targetsToBeAddded, String quarter) 
	{
		float risk = 0;
		float avgRiskForQuarter = 0;
		for (Map<String, String> map : targetsToBeAddded) 
		{
			for (Entry<String, String> entry : map.entrySet()) 
			{
				try
				{
					if(entry.getKey().equals("completed"))
						avgRiskForQuarter += Float.parseFloat(entry.getValue());
				}
				catch(NumberFormatException ex)
				{
					continue;
				}
			}
		}
		
		avgRiskForQuarter /= targetsToBeAddded.size();
		int noOfDaysPassedInQuarter = calculateDaysPassedInQuarter(quarter);
		risk = 100 - ((avgRiskForQuarter * 90) / noOfDaysPassedInQuarter);
		if(risk < 0)
			risk = 0;
		return String.valueOf(risk);
	}

	private int calculateDaysPassedInQuarter(String quarter) 
	{
		int noOfDaysPassedInQuarter = 0;
		
		DateTime currentDay = DateTime.now();
		DateTime qStart;
		if(quarter.equals("Quarter 1"))
		{
			qStart = new DateTime(currentDay.getYear(), 10, 1, 0, 0, 0);
			noOfDaysPassedInQuarter = Days.daysBetween(qStart.toLocalDate(), currentDay.toLocalDate()).getDays();
		}
		else if(quarter.equals("Quarter 2"))
		{
			qStart = new DateTime(currentDay.getYear(), 1, 1, 0, 0, 0);
			noOfDaysPassedInQuarter = Days.daysBetween(qStart.toLocalDate(), currentDay.toLocalDate()).getDays();
		}
		else if(quarter.equals("Quarter 3"))
		{
			qStart = new DateTime(currentDay.getYear(), 4, 1, 0, 0, 0);
			noOfDaysPassedInQuarter = Days.daysBetween(qStart.toLocalDate(), currentDay.toLocalDate()).getDays();
		}
		else
		{
			qStart = new DateTime(currentDay.getYear(), 7, 1, 0, 0, 0);
			noOfDaysPassedInQuarter = Days.daysBetween(qStart.toLocalDate(), currentDay.toLocalDate()).getDays();
		}
		if(noOfDaysPassedInQuarter == 0)
			return 1;
		return noOfDaysPassedInQuarter;
	}

	public String getRiskForCurrentQuarter(String user, String quarter) throws Exception 
	{
		return dbService.getRiskForQuarter(user, quarter);
	}
}