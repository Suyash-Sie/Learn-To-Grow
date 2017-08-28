package com.siemens.learn;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController 
{
	private DBService dbService;

	public UserController()
	{
		dbService = new DBService();
	}
	
	@RequestMapping(value = "/userscreen", method = RequestMethod.GET)
	public String welcome(ModelMap model, @ModelAttribute("user") String user) 
	{
		List<Target> targets = new TargetService(dbService).getTargetsForUser(user);
		int currentMonth = Calendar.getInstance().get(Calendar.MONTH);
		if(currentMonth > 9)
		{
			model.addAttribute("tab1", "true");
		}
		else if(currentMonth < 4)
		{
			model.addAttribute("tab1", "false");
			model.addAttribute("tab2", "true");
		}
		else if(currentMonth < 7)
		{
			model.addAttribute("tab2", "false");
			model.addAttribute("tab3", "true");
		}
		else if(currentMonth < 10)
		{
			model.addAttribute("tab3", "false");
			model.addAttribute("tab4", "true");
		}	
		model.addAttribute("targets", targets);
		
		return "userscreen";
	}

	@RequestMapping(value = "userscreen/submit", method = RequestMethod.POST)
	public String submit(ModelMap model, @RequestParam String quarter) 
	{
		List<Target> targets = new ArrayList<>();
//		targets.add(new Target("Target 1", "Category 1", 25F));
//		targets.add(new Target("Target 2", "Category 2", 31F));
//		targets.add(new Target("Target 3", "Category 3", 42F));
//		targets.add(new Target("Target 4", "Category 4", 11F));
//		targets.add(new Target("Target 5", "Category 5", 19F));
//		targets.add(new Target("Target 6", "Category 6", 27F));
		model.addAttribute("targets", targets);
		
		return "userscreen";
	}
}
