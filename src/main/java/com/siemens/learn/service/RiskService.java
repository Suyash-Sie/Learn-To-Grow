package com.siemens.learn.service;

import java.util.List;

import com.siemens.learn.model.Groups;
import com.siemens.learn.model.Risk;

public class RiskService 
{
	private DBService dbService;

	public RiskService(DBService dbService)
	{
		this.dbService = dbService;
	}
	
	public Risk getAllRisks() 
	{
		Risk risk = new Risk();
		float lobRisk = 0;
		for (Groups groups : Groups.values()) 
		{
			List<List<String>> riskForGroup = dbService.getRiskForGroup(groups.name());
			float groupRisk = 0;
			int riskCount = 0;
			for (List<String> riskPerUser : riskForGroup) 
			{
				for (String riskPerQuarter : riskPerUser) 
				{
					groupRisk += Float.parseFloat(riskPerQuarter);
					riskCount++;
				}
			}
			if(riskCount != 0)
				groupRisk /= riskCount;
			lobRisk += groupRisk;
			if(groups.equals(Groups.R7))
				risk.setR7Risk(groupRisk);
			else if(groups.equals(Groups.R8))
				risk.setR8Risk(groupRisk);
			else if(groups.equals(Groups.SIT))
				risk.setSitRisk(groupRisk);
			else if(groups.equals(Groups.SYS))
				risk.setSysRisk(groupRisk);
			else if(groups.equals(Groups.TDOC))
				risk.settDocRisk(groupRisk);
		}
		risk.setLobRisk(lobRisk/Groups.values().length);
		
		return risk;
	}

	public String calculateNewRisk(List<String> groups) 
	{
		float lobRisk = 0;
		for (String group : groups) 
		{
			List<List<String>> riskForGroup = dbService.getRiskForGroup(group);
			float groupRisk = 0;
			int riskCount = 0;
			for (List<String> riskPerUser : riskForGroup) 
			{
				for (String riskPerQuarter : riskPerUser) 
				{
					groupRisk += Float.parseFloat(riskPerQuarter);
					riskCount++;
				}
			}
			if(riskCount != 0)
				groupRisk /= riskCount;
			lobRisk += groupRisk;
		}
		lobRisk /= Groups.values().length;
		return String.valueOf(lobRisk);
	}
}
