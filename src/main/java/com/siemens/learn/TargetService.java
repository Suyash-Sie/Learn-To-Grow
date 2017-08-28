package com.siemens.learn;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class TargetService 
{
	private DBService dbService;
	
	public TargetService(DBService dbService)
	{
		this.dbService = dbService;
		
	}
	
	public List<Target> getTargetsForUser(String gid)
	{
		List<Target> targets = new ArrayList<>();
		List<Map<String, String>> targetsFromDb = dbService.getTargets(gid);
		for (Map<String, String> map : targetsFromDb) 
		{
			Target target = new Target();
			for (Entry<String, String> entry : map.entrySet()) 
			{
				if(entry.getKey().equals("name"))
					target.setTargetName(entry.getValue());
				else if(entry.getKey().equals("category"))
					target.setCategory(entry.getValue());
				else
					target.setCompletionPercent(entry.getValue());
			}
			targets.add(target);
		}
		return targets;
	}
	
	public void updateTargets(String gid, List<Target> targets)
	{
		List<Map<String, String>> targetsToBeAddded = dbService.getTargets(gid);
		
		for (Target target : targets) 
		{
			Map<String, String> targetDetails = new HashMap<>();
			targetDetails.put("name", target.getTargetName());
			targetDetails.put("category", target.getCategory());
			targetDetails.put("completed", target.getCompletionPercent());
			targetDetails.put("quarter", target.getQuarter());
			
			targetsToBeAddded.add(targetDetails);
		}
		
		String risk = calculateRisk(targetsToBeAddded);
		dbService.submit(gid, targetsToBeAddded, risk);
	}

	private String calculateRisk(List<Map<String, String>> targetsToBeAddded) 
	{
		float risk = 0;
		for (Map<String, String> map : targetsToBeAddded) 
		{
			for (Entry<String, String> entry : map.entrySet()) 
			{
				try
				{
					if(entry.getKey().equals("completed"))
						risk += Float.parseFloat(entry.getValue());
				}
				catch(NumberFormatException ex)
				{
					continue;
				}
			}
		}
		risk = risk/targetsToBeAddded.size();
		return String.valueOf(risk);
	}
}
