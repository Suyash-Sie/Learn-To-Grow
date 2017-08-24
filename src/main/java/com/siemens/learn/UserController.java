package com.siemens.learn;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController 
{
	@RequestMapping(value = "/userscreen", method = RequestMethod.GET)
	public String welcome(ModelMap model) 
	{
		List<Target> targets = new ArrayList<>();
		targets.add(new Target("Target 1", "Category 1", 25F));
		targets.add(new Target("Target 2", "Category 2", 31F));
		targets.add(new Target("Target 3", "Category 3", 42F));
		targets.add(new Target("Target 4", "Category 4", 11F));
		targets.add(new Target("Target 5", "Category 5", 19F));
		model.addAttribute("targets", targets);
		
		return "userscreen";
	}
}
