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
        List<Target> targets = new TargetService(dbService).getTargetsForUser(user, "Q1");
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
	public String submit(HttpServletRequest request, ModelMap model) 
	{
		String quarter = request.getParameter("tab");
		List<Target> targetsInDb = new TargetService(dbService).getTargetsForUser(user, quarter);
		
		String targetName0 = request.getParameter("targetName0");
		String targetName1 = request.getParameter("targetName1");
		String targetName2 = request.getParameter("targetName2");
		String targetName3 = request.getParameter("targetName3");
		
		String category0 = request.getParameter("category0");
		String category1 = request.getParameter("category1");
		String category2 = request.getParameter("category2");
		String category3 = request.getParameter("category3");

		String completion0 = request.getParameter("completion0");
		String completion1 = request.getParameter("completion1");
		String completion2 = request.getParameter("completion2");
		String completion3 = request.getParameter("completion3");
		
		List<Target> targets = new ArrayList<>();
		Target target1 = createTarget(targetName0, category0, completion0, quarter);
		if(target1 != null && !targetsInDb.contains(target1))
			targets.add(target1);
		Target target2 = createTarget(targetName1, category1, completion1, quarter);
		if(target2 != null && !targetsInDb.contains(target2))
			targets.add(target2);
		Target target3 = createTarget(targetName2, category2, completion2, quarter);
		if(target3 != null && !targetsInDb.contains(target3))
			targets.add(target3);
		Target target4 = createTarget(targetName3, category3, completion3, quarter);
		if(target4 != null && !targetsInDb.contains(target4))
			targets.add(target4);
		
		if(targets.size() != 0)
			new TargetService(dbService).submitTargets(user, targets);
		model.addAttribute("targets", targets);
		
		return "redirect:userscreen";
	}

	private Target createTarget(String targetName, String category, String completion, String tabbed1) 
	{
		if(targetValid(targetName, category, completion))
		{
			Target target = new Target();
			target.setTargetName(targetName);
			target.setCategory(category);
			target.setCompletionPercent(completion);
			target.setQuarter(tabbed1);
			return target;
		}
		return null;
	}

	private boolean targetValid(String name, String category, String completion)
	{
		boolean valid = false;
		if(null != name && !name.isEmpty() && null != category && !category.isEmpty() 
				&& null != completion && !completion.isEmpty() && Float.parseFloat(completion) > 0 && Float.parseFloat(completion) < 100)
			valid = true;
		return valid;
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