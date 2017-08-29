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
	
	public boolean userValidated(String gid, String password)
	{
		String passInDb = dbService.getPassword(gid);
		if(null != passInDb && bCryptPasswordEncoder.matches(password, passInDb))
			return true;
		return false;
	}
	
	public String getUserRole(String gid)
	{
		return dbService.getRole(gid);
	}
}
