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
	
	public Risk getAllRisks() throws Exception 
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
			else if(groups.equals(Groups.PRM))
				risk.setPrmRisk(groupRisk);
		}
		risk.setLobRisk(lobRisk/Groups.values().length);
		
		return risk;
	}

	public Risk calculateNewRisk(Risk currentRisks, List<String> groups, List<String> quarters) throws Exception 
	{
		float lobRisk = 0;
		for (String group : groups) 
		{
			float quarterRisk = 0;
			int riskCount = 0;
			for(String quarter : quarters)
			{
				List<String> riskForGroupAndQuarter = dbService.getRiskForGroupAndQuarter(group, quarter);
				for (String riskPerUser : riskForGroupAndQuarter) 
				{
					quarterRisk += Float.parseFloat(riskPerUser);
					riskCount++;
				}
			}
			if(riskCount != 0)
				quarterRisk /= riskCount;
			lobRisk += quarterRisk;
			if(groups.equals(Groups.R7))
				currentRisks.setR7Risk(quarterRisk);
			else if(groups.equals(Groups.R8))
				currentRisks.setR8Risk(quarterRisk);
			else if(groups.equals(Groups.SIT))
				currentRisks.setSitRisk(quarterRisk);
			else if(groups.equals(Groups.SYS))
				currentRisks.setSysRisk(quarterRisk);
			else if(groups.equals(Groups.TDOC))
				currentRisks.settDocRisk(quarterRisk);
			else if(groups.equals(Groups.PRM))
				currentRisks.setPrmRisk(quarterRisk);
		}
		lobRisk /= Groups.values().length;
		currentRisks.setLobRisk(lobRisk);
		return currentRisks;
	}
}
