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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String welcome(ModelMap model, @ModelAttribute("user") String user, @ModelAttribute("quarter") String quarter) 
	{
		this.user = user;
        List<Target> targets = new TargetService(dbService).getTargetsForUser(user, quarter);
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

	@RequestMapping(value = "submit", method = RequestMethod.POST, params="add")
	public ModelAndView submit(HttpServletRequest request, ModelMap model, final RedirectAttributes redirectAttributes) 
	{
		String quarter = request.getParameter("tab");
		List<Target> targetsInDb = new TargetService(dbService).getTargetsForUser(user, quarter);
		
		List<String> targetDetails = new ArrayList<>();
		if(quarter.equals("Quarter 1"))
			populateDataForQ1(request, targetDetails);
		else if(quarter.equals("Quarter 2"))
			populateDataForQ2(request, targetDetails);
		else if(quarter.equals("Quarter 3"))
			populateDataForQ3(request, targetDetails);
		else
			populateDataForQ4(request, targetDetails);
		
		List<Target> targets = new ArrayList<>();
		Target target1 = createTarget(targetDetails.get(0), targetDetails.get(1), targetDetails.get(2), targetDetails.get(3), quarter);
		if(target1 != null && !targetsInDb.contains(target1))
			targets.add(target1);
		Target target2 = createTarget(targetDetails.get(4), targetDetails.get(5), targetDetails.get(6), targetDetails.get(7), quarter);
		if(target2 != null && !targetsInDb.contains(target2))
			targets.add(target2);
		Target target3 = createTarget(targetDetails.get(8), targetDetails.get(9), targetDetails.get(10), targetDetails.get(11), quarter);
		if(target3 != null && !targetsInDb.contains(target3))
			targets.add(target3);
		Target target4 = createTarget(targetDetails.get(12), targetDetails.get(13), targetDetails.get(14), targetDetails.get(15), quarter);
		if(target4 != null && !targetsInDb.contains(target4))
			targets.add(target4);
		
		if(targets.size() != 0)
			new TargetService(dbService).submitTargets(user, targets);
		model.addAttribute("targets", new TargetService(dbService).getTargetsForUser(user, quarter));
		
		redirectAttributes.addFlashAttribute("user", user);
		redirectAttributes.addFlashAttribute("quarter", quarter);
		return new ModelAndView("redirect:userscreen");
	}

	private void populateDataForQ1(HttpServletRequest request, List<String> targetDetails) 
	{
		targetDetails.add(request.getParameter("targetName0"));
		targetDetails.add(request.getParameter("category0"));
		targetDetails.add(request.getParameter("level0"));
		targetDetails.add(request.getParameter("completion0"));
		
		targetDetails.add(request.getParameter("targetName1"));
		targetDetails.add(request.getParameter("category1"));
		targetDetails.add(request.getParameter("level1"));
		targetDetails.add(request.getParameter("completion1"));

		targetDetails.add(request.getParameter("targetName2"));
		targetDetails.add(request.getParameter("category2"));
		targetDetails.add(request.getParameter("level2"));
		targetDetails.add(request.getParameter("completion2"));

		targetDetails.add(request.getParameter("targetName3"));
		targetDetails.add(request.getParameter("category3"));
		targetDetails.add(request.getParameter("level3"));
		targetDetails.add(request.getParameter("completion3"));
	}

	private void populateDataForQ2(HttpServletRequest request, List<String> targetDetails) 
	{
		targetDetails.add(request.getParameter("targetName4"));
		targetDetails.add(request.getParameter("category4"));
		targetDetails.add(request.getParameter("level4"));
		targetDetails.add(request.getParameter("completion4"));

		targetDetails.add(request.getParameter("targetName5"));
		targetDetails.add(request.getParameter("category5"));
		targetDetails.add(request.getParameter("level5"));
		targetDetails.add(request.getParameter("completion5"));

		targetDetails.add(request.getParameter("targetName6"));
		targetDetails.add(request.getParameter("category6"));
		targetDetails.add(request.getParameter("level6"));
		targetDetails.add(request.getParameter("completion6"));

		targetDetails.add(request.getParameter("targetName7"));
		targetDetails.add(request.getParameter("category7"));
		targetDetails.add(request.getParameter("level7"));
		targetDetails.add(request.getParameter("completion7"));
	}

	private void populateDataForQ3(HttpServletRequest request, List<String> targetDetails) 
	{
		targetDetails.add(request.getParameter("targetName8"));
		targetDetails.add(request.getParameter("category8"));
		targetDetails.add(request.getParameter("level8"));
		targetDetails.add(request.getParameter("completion8"));
		
		targetDetails.add(request.getParameter("targetName9"));
		targetDetails.add(request.getParameter("category9"));
		targetDetails.add(request.getParameter("level9"));
		targetDetails.add(request.getParameter("completion9"));
		
		targetDetails.add(request.getParameter("targetName10"));
		targetDetails.add(request.getParameter("category10"));
		targetDetails.add(request.getParameter("level10"));
		targetDetails.add(request.getParameter("completion10"));
		
		targetDetails.add(request.getParameter("targetName11"));
		targetDetails.add(request.getParameter("category11"));
		targetDetails.add(request.getParameter("level11"));
		targetDetails.add(request.getParameter("completion11"));
	}

	private void populateDataForQ4(HttpServletRequest request, List<String> targetDetails) 
	{
		targetDetails.add(request.getParameter("targetName12"));
		targetDetails.add(request.getParameter("category12"));
		targetDetails.add(request.getParameter("level12"));
		targetDetails.add(request.getParameter("completion12"));
		
		targetDetails.add(request.getParameter("targetName13"));
		targetDetails.add(request.getParameter("category13"));
		targetDetails.add(request.getParameter("level13"));
		targetDetails.add(request.getParameter("completion13"));
		
		targetDetails.add(request.getParameter("targetName14"));
		targetDetails.add(request.getParameter("category14"));
		targetDetails.add(request.getParameter("level14"));
		targetDetails.add(request.getParameter("completion14"));
		
		targetDetails.add(request.getParameter("targetName15"));
		targetDetails.add(request.getParameter("category15"));
		targetDetails.add(request.getParameter("completion15"));
		targetDetails.add(request.getParameter("level15"));
	}

	private Target createTarget(String targetName, String category, String level, String completion, String quarter) 
	{
		if(targetValid(targetName, category, level))
		{
			Target target = new Target();
			target.setTargetName(targetName);
			target.setCategory(category);
			target.setLevel(level);
			if(null == completion || completion.isEmpty())
				completion = "0";
			target.setCompletionPercent(completion);
			target.setQuarter(quarter);
			return target;
		}
		return null;
	}

	private boolean targetValid(String name, String category, String level)
	{
		boolean valid = false;
		if(null != name && !name.isEmpty() && null != category && !category.isEmpty() && null != level && !level.isEmpty())
			valid = true;
		return valid;
	}
	
	@RequestMapping(value = "submit", method = RequestMethod.POST, params="tab")
	public ModelAndView tacbChanged(HttpServletRequest request, ModelMap model, final RedirectAttributes redirectAttributes) 
	{
		String quarter = request.getParameter("tab");
		redirectAttributes.addFlashAttribute("user", user);
		redirectAttributes.addFlashAttribute("quarter", quarter);
		return new ModelAndView("redirect:userscreen");
	}
}