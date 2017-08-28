package com.siemens.learn;

public class Target 
{
	private String targetName;
	private String category;
	private String completionPercent;
	private String quarter;

	public String getQuarter() {
		return quarter;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
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

	public String getCompletionPercent() 
	{
		return completionPercent;
	}

	public void setCompletionPercent(String completionPercent) 
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
