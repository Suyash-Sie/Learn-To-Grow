package com.siemens.learn.model;

public class Target 
{
	private String targetName;
	private String category;
	private String completionPercent;
	private String quarter;
	private String level;

	public String getQuarter() 
	{
		return quarter;
	}

	public void setQuarter(String quarter) 
	{
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

	public String getLevel() 
	{
		return level;
	}
	
	public void setLevel(String level) 
	{
		this.level = level;
	}
	
	@Override
	public String toString() 
	{
		return "Target [targetName=" + targetName + ", category=" + category + ", completionPercent="
				+ completionPercent + ", quarter=" + quarter + ", level=" + level + "]";
	}
	
	@Override
	public int hashCode() 
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((category == null) ? 0 : category.hashCode());
		result = prime * result + ((quarter == null) ? 0 : quarter.hashCode());
		result = prime * result + ((targetName == null) ? 0 : targetName.hashCode());
		result = prime * result + ((completionPercent == null) ? 0 : completionPercent.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) 
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Target other = (Target) obj;
		if (category == null) 
		{
			if (other.category != null)
				return false;
		} 
		else if (!category.equals(other.category))
			return false;
		if (quarter == null) 
		{
			if (other.quarter != null)
				return false;
		} 
		else if (!quarter.equals(other.quarter))
			return false;
		if (targetName == null) 
		{
			if (other.targetName != null)
				return false;
		} 
		else if (!targetName.equals(other.targetName))
			return false;
		if (completionPercent == null) 
		{
			if (other.completionPercent != null)
				return false;
		} 
		else if (!completionPercent.equals(other.completionPercent))
			return false;
		return true;
	}
}
