package com.siemens.learn;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class TargetService 
{
	public List<Target> getTargetsForUser(String username)
	{
		URL resource = getClass().getClassLoader().getResource("targets.txt");
		String fileName = resource.getFile();

		List<Target> targets = new ArrayList<>();
		try (BufferedReader br = new BufferedReader(new FileReader(fileName))) 
		{
			String line;
			while ((line = br.readLine()) != null) 
			{
				String[] contents = line.split(",");
				if(username.equals(contents[0]))
					targets.add(new Target(contents[1], contents[2], Float.parseFloat(contents[3])));
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return targets;
	}
	
}
