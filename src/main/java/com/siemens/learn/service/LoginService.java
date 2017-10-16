package com.siemens.learn.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class LoginService 
{
	private DBService dbService;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public LoginService(DBService dbService, BCryptPasswordEncoder bCryptPasswordEncoder)
	{
		this.dbService = dbService;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	public boolean userValidated(String gid, String password) throws Exception
	{
		String passInDb = dbService.getPassword(gid.toUpperCase());
		if(null != passInDb && bCryptPasswordEncoder.matches(password, passInDb))
			return true;
		return false;
	}
	
	public String getUserName(String gid) throws Exception
	{
		return dbService.getName(gid.toUpperCase());
	}
	
	public String getUserRole(String gid) throws Exception
	{
		return dbService.getRole(gid.toUpperCase());
	}

	public boolean hasUserChangedPassword(String gid) throws Exception 
	{
		String passwordChanged = dbService.getPasswordChanged(gid.toUpperCase());
		return Boolean.valueOf(passwordChanged);
	}

	public void updatePassword(String gid, String newPassword) throws Exception 
	{
		String encodedPassword = bCryptPasswordEncoder.encode(newPassword);
		dbService.updatePassword(gid.toUpperCase(), encodedPassword);
	}
	
	public static void main(String[] args) 
	{
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println(encoder.encode("guest"));
	}
}
