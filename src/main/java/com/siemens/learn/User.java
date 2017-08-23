package com.siemens.learn;

import java.util.List;

public class User 
{
	private String username;
	private List<Target> targets;
	private float risk;

	public String getUsername() 
	{
		return username;
	}

	public void setUsername(String username) 
	{
		this.username = username;
	}

	public List<Target> getTargets() 
	{
		return targets;
	}

	public void setTargets(List<Target> targets) 
	{
		this.targets = targets;
	}

	public float getRisk() 
	{
		return risk;
	}

	public void setRisk(float risk) 
	{
		this.risk = risk;
	}
}
