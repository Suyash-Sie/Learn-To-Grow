package com.siemens.learn;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

public class LoginService 
{
	public boolean userValidated(String username, String password)
	{
		URL resource = getClass().getClassLoader().getResource("user.txt");
		String fileName = resource.getFile();

		try (BufferedReader br = new BufferedReader(new FileReader(fileName))) 
		{
			String line;
			while ((line = br.readLine()) != null) 
			{
				String[] contents = line.split(",");
				if(username.equals(contents[0]) && password.equals(contents[1]))
					return true;
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
}
