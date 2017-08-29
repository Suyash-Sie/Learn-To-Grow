package com.siemens.learn;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.siemens.learn.model.Target;
import com.siemens.learn.service.DBService;
import com.siemens.learn.service.TargetService;

@Controller
public class UserController 
{
	private DBService dbService;
    private String user;

	public UserController()
	{
		dbService = new DBService();
	}
	
	@RequestMapping(value = "/userscreen", method = RequestMethod.GET)
	public String welcome(ModelMap model, @ModelAttribute("user") String user) 
	{
		this.user = user;
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

	@RequestMapping(value = "userscreen/submit", method = RequestMethod.POST, params="add")
	public String submit(HttpServletRequest request, ModelMap model, @RequestParam String tabbed1) 
	{
		String targetName = request.getParameter("targetName");
		String category = request.getParameter("category");
		if(targetName.isEmpty() || category.isEmpty())
			return "userscreen";
			
		List<Target> targets = new ArrayList<>();
		Target target = new Target();
		target.setTargetName(targetName);
		target.setCategory(category);
		target.setCompletionPercent("0");
		target.setQuarter(tabbed1);
		targets.add(target);
		
		new TargetService(dbService).submitTargets(user, targets);
		model.addAttribute("targets", targets);
		
		return "userscreen";
	}

	@RequestMapping(value = "userscreen/submit", params="update", method = RequestMethod.POST)
	public String update(HttpServletRequest request, ModelMap model, @RequestParam String tabbed1) 
	{
		String targetName = request.getParameter("targetName");
		String category = request.getParameter("category");
		String completionPercent = request.getParameter("completionPercent");
		if(targetName.isEmpty() || category.isEmpty() || Float.parseFloat(completionPercent) > 100 
				|| Float.parseFloat(completionPercent) < 0)
			return "userscreen";
		List<Target> targets = new ArrayList<>();
		Target target = new Target();
		target.setTargetName(targetName);
		target.setCategory(category);
		target.setCompletionPercent(completionPercent);
		target.setQuarter(tabbed1);
		targets.add(target);
		
		new TargetService(dbService).submitTargets(user, targets);
		model.addAttribute("targets", targets);
		
		return "userscreen";
	}
}
