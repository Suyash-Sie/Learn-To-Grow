package com.siemens.learn;

public class Target 
{
	private String targetName;
	private String category;
	private float completionPercent;

	public Target(String target, String category, float completionPercent)
	{
		this.targetName = target;
		this.category = category;
		this.completionPercent = completionPercent;
	}
	
	public String getTargetName() 
	{
		return targetName;
	}

	public void setTargetName(String targetName) 
	{
		this.targetName = targetName;
	}

	public String getCategory() 
	{
		return category;
	}

	public void setCategory(String category) 
	{
		this.category = category;
	}

	public float getCompletionPercent() 
	{
		return completionPercent;
	}

	public void setCompletionPercent(float completionPercent) 
	{
		this.completionPercent = completionPercent;
	}

	@Override
	public String toString() 
	{
		return "Target [targetName=" + targetName + ", category=" + category + ", completionPercent="
				+ completionPercent + "]";
	}
}
