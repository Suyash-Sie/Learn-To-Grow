package com.siemens.learn;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.siemens.learn.model.Target;
import com.siemens.learn.service.DBService;
import com.siemens.learn.service.TargetService;

@Controller
public class UserController 
{
	private DBService dbService;
    private String user;
    private String name;
	private TargetService targetService;

	public UserController()
	{
		dbService = new DBService();
		targetService = new TargetService(dbService);
	}
	
	@RequestMapping(value = "/userscreen", method = RequestMethod.GET)
	public ModelAndView welcome(ModelAndView modelAndView, @ModelAttribute("user") String user, @ModelAttribute("name") String name,@ModelAttribute("quarter") String quarter) 
	{
		this.user = user;
		this.name = name;
		try
		{
			Map<String, List<Target>> targetsPerQuarter = new HashMap<>();
	        List<Target> q1Targets = targetService.getTargetsForUser(user, "Quarter 1");
	        List<Target> q2Targets = targetService.getTargetsForUser(user, "Quarter 2");
	        List<Target> q3Targets = targetService.getTargetsForUser(user, "Quarter 3");
	        List<Target> q4Targets = targetService.getTargetsForUser(user, "Quarter 4");
	        
	        targetsPerQuarter.put("Quarter 1", q1Targets);
	        targetsPerQuarter.put("Quarter 2", q2Targets);
	        targetsPerQuarter.put("Quarter 3", q3Targets);
	        targetsPerQuarter.put("Quarter 4", q4Targets);
	        
	        String currentRisk = targetService.getRiskForCurrentQuarter(user, quarter);
	        
			int currentMonth = Calendar.getInstance().get(Calendar.MONTH);
			if(currentMonth > 9)
			{
				modelAndView.addObject("tab1", "true");
			}
			else if(currentMonth < 4)
			{
				modelAndView.addObject("tab1", "false");
				modelAndView.addObject("tab2", "true");
			}
			else if(currentMonth < 7)
			{
				modelAndView.addObject("tab2", "false");
				modelAndView.addObject("tab3", "true");
			}
			else if(currentMonth < 10)
			{
				modelAndView.addObject("tab3", "false");
				modelAndView.addObject("tab4", "true");
			}
			modelAndView.addObject("q1", q1Targets);
			modelAndView.addObject("q2", q2Targets);
			modelAndView.addObject("q3", q3Targets);
			modelAndView.addObject("q4", q4Targets);
			modelAndView.addObject("currentRisk", currentRisk);
			modelAndView.addObject("currentQuarter", quarter);
			modelAndView.addObject("targets", targetsPerQuarter);
			
			modelAndView.setViewName("userscreen");
		}
		catch(Exception e)
		{
			
		}
		return modelAndView;
	}

	@RequestMapping(value = "submit", method = RequestMethod.POST, params="add")
	public ModelAndView submit(HttpServletRequest request, ModelMap model, final RedirectAttributes redirectAttributes) 
	{
		try
		{
			String quarter = request.getParameter("tab");
			
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
			if(target1 != null)
				targets.add(target1);
			Target target2 = createTarget(targetDetails.get(4), targetDetails.get(5), targetDetails.get(6), targetDetails.get(7), quarter);
			if(target2 != null)
				targets.add(target2);
			Target target3 = createTarget(targetDetails.get(8), targetDetails.get(9), targetDetails.get(10), targetDetails.get(11), quarter);
			if(target3 != null)
				targets.add(target3);
			Target target4 = createTarget(targetDetails.get(12), targetDetails.get(13), targetDetails.get(14), targetDetails.get(15), quarter);
			if(target4 != null)
				targets.add(target4);
			
			if(targets.size() != 0)
				targetService.submitTargets(user, targets, quarter);
			model.addAttribute("targets", targetService.getTargetsForUser(user, quarter));
			
			redirectAttributes.addFlashAttribute("user", user);
			redirectAttributes.addFlashAttribute("name", name);
			redirectAttributes.addFlashAttribute("quarter", quarter);
			model.addAttribute("quarter", quarter);
		}
		catch(Exception e)
		{
			
		}
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
		targetDetails.add(request.getParameter("level15"));
		targetDetails.add(request.getParameter("completion15"));
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
			target.setYear(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
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
	
	@RequestMapping(value = "/radio",  method = RequestMethod.GET)
	@ResponseBody
	public String tabChanged(Model model, HttpServletRequest req) 
	{
		try
		{
			String quarter = req.getParameter("tab");
			
			List<Target> targets = targetService.getTargetsForUser(user, quarter);
			ObjectMapper mapper = new ObjectMapper();
	
			String jsonInString = "";
				jsonInString = mapper.writeValueAsString(targets);
			return jsonInString;
		}
		catch(Exception e)
		{
			return "";
		}
	}
	
}
