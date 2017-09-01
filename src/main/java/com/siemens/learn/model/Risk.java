package com.siemens.learn.model;

public class Risk 
{
	private float r7Risk;
	private float r8Risk;
	private float sitRisk;
	private float sysRisk;
	private float tDocRisk;
	private float lobRisk;
	
	public float getR7Risk() 
	{
		return r7Risk;
	}
	
	public void setR7Risk(float r7Risk) 
	{
		this.r7Risk = r7Risk;
	}
	
	public float getR8Risk() 
	{
		return r8Risk;
	}
	
	public void setR8Risk(float r8Risk) 
	{
		this.r8Risk = r8Risk;
	}
	
	public float getSitRisk() 
	{
		return sitRisk;
	}
	
	public void setSitRisk(float sitRisk) 
	{
		this.sitRisk = sitRisk;
	}
	
	public float getSysRisk() 
	{
		return sysRisk;
	}
	
	public void setSysRisk(float sysRisk) 
	{
		this.sysRisk = sysRisk;
	}
	
	public float gettDocRisk() 
	{
		return tDocRisk;
	}
	
	public void settDocRisk(float tDocRisk) 
	{
		this.tDocRisk = tDocRisk;
	}

	public float getLobRisk() 
	{
		return lobRisk;
	}

	public void setLobRisk(float lobRisk) 
	{
		this.lobRisk = lobRisk;
	}
	
	@Override
	public String toString() 
	{
		return "Risk [r7Risk=" + r7Risk + ", r8Risk=" + r8Risk + ", sitRisk=" + sitRisk + ", sysRisk=" + sysRisk
				+ ", tDocRisk=" + tDocRisk + ", lobRisk=" + lobRisk + "]";
	}
}