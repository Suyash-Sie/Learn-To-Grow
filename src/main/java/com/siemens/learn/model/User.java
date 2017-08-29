package com.siemens.learn.model;

import java.util.List;

public class User 
{
	private String gid;
	private List<Target> targets;
	private float risk;

	public String getGid() 
	{
		return gid;
	}

	public void setGid(String gid) 
	{
		this.gid = gid;
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
