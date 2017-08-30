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
	
	public List<Target> getTargetsForUser(String gid, String quarter)
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
				else
					target.setQuarter(entry.getValue());
			}
			targets.add(target);
		}
		return targets;
	}
	
	public void submitTargets(String gid, List<Target> targets)
	{
		List<Map<String, String>> targetsToBeAddded = dbService.getTargets(gid, "Quarter 1");
		String quarter = "";
		for (Target target : targets) 
		{
			Map<String, String> targetDetails = new HashMap<>();
			targetDetails.put("name", target.getTargetName());
			targetDetails.put("category", target.getCategory());
			targetDetails.put("level", target.getLevel());
			targetDetails.put("completed", target.getCompletionPercent());
			quarter = target.getQuarter();
			targetDetails.put("quarter", quarter);
			
			targetsToBeAddded.add(targetDetails);
		}
		
		String risk = calculateRisk(targetsToBeAddded, quarter);
		
		dbService.submit(gid, targetsToBeAddded, risk, quarter);
	}

	private String calculateRisk(List<Map<String, String>> targetsToBeAddded, String quarter) 
	{
		float risk = 0;
		float remaining = 0;
		for (Map<String, String> map : targetsToBeAddded) 
		{
			for (Entry<String, String> entry : map.entrySet()) 
			{
				try
				{
					if(entry.getKey().equals("completed"))
						remaining += 100 - Float.parseFloat(entry.getValue());
				}
				catch(NumberFormatException ex)
				{
					continue;
				}
			}
		}
		
		remaining /= targetsToBeAddded.size();
		int noOfDaysLeftInQuarter = calculateDaysLeftInQuarter(quarter);
		risk = remaining/noOfDaysLeftInQuarter;
		return String.valueOf(risk);
	}

	private int calculateDaysLeftInQuarter(String quarter) 
	{
		int noOfDaysLeftInQuarter = 0;
		
		DateTime currentDay = DateTime.now();
		DateTime qEnd;
		if(quarter.equals("Quarter 1"))
		{
			qEnd = new DateTime(currentDay.getYear()+1, 1, 1, 0, 0, 0);
			noOfDaysLeftInQuarter = Days.daysBetween(currentDay.toLocalDate(), qEnd.toLocalDate()).getDays();
		}
		else if(quarter.equals("Quarter 2"))
		{
			qEnd = new DateTime(currentDay.getYear(), 4, 1, 0, 0, 0);
			noOfDaysLeftInQuarter = Days.daysBetween(currentDay.toLocalDate(), qEnd.toLocalDate()).getDays();
		}
		else if(quarter.equals("Quarter 3"))
		{
			qEnd = new DateTime(currentDay.getYear(), 7, 1, 0, 0, 0);
			noOfDaysLeftInQuarter = Days.daysBetween(currentDay.toLocalDate(), qEnd.toLocalDate()).getDays();
		}
		else
		{
			qEnd = new DateTime(currentDay.getYear(), 10, 1, 0, 0, 0);
			noOfDaysLeftInQuarter = Days.daysBetween(currentDay.toLocalDate(), qEnd.toLocalDate()).getDays();
		}
		return noOfDaysLeftInQuarter;
	}
}
