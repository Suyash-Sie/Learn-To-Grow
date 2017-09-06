package com.siemens.learn;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.siemens.learn.service.DBService;
import com.siemens.learn.service.LoginService;

@Controller
public class HelloController 
{
	private DBService dbService;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	private LoginService loginService;
	private String gid;
	
	public HelloController()
	{
		dbService = new DBService();
		bCryptPasswordEncoder = new BCryptPasswordEncoder();
		loginService = new LoginService(dbService, bCryptPasswordEncoder);
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() 
	{
		return "hello";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logout(ModelMap model)
	{
		model.addAttribute("message", "You have been successfully logged out!");
		return "logout";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGet()
	{
 		return "hello";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(ModelMap model, HttpServletRequest request, final RedirectAttributes redirectAttributes) 
	{
		try
		{
			String password = request.getParameter("password");
			this.gid = request.getParameter("gid");
			if(!loginService.userValidated(gid, password))
			{
				model.addAttribute("message", "Invalid credentials provided!");
				return "hello";
			}
			else if(!loginService.hasUserChangedPassword(gid))
				return "change_password";
			
			redirectAttributes.addFlashAttribute("user", gid);
			if(loginService.getUserRole(gid).equals("manager"))
				return "redirect:userscreen_admin";
			
			setRedirectAttributes(gid, redirectAttributes);
			
			return "redirect:userscreen";
		}
		catch(Exception e)
		{
			return "hello";
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet()
	{
 		return "hello";
	}
	
	private void setRedirectAttributes(String gid, final RedirectAttributes redirectAttributes) throws Exception 
	{
		String name = loginService.getUserName(gid);
		redirectAttributes.addFlashAttribute("name", name);
		
		int currentMonth = Calendar.getInstance().get(Calendar.MONTH);
		if(currentMonth > 9)
			redirectAttributes.addFlashAttribute("quarter", "Quarter 1");
		else if(currentMonth < 4)
			redirectAttributes.addFlashAttribute("quarter", "Quarter 2");
		else if(currentMonth < 7)
			redirectAttributes.addFlashAttribute("quarter", "Quarter 3");
		else if(currentMonth < 10)
			redirectAttributes.addFlashAttribute("quarter", "Quarter 4");
	}
	
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest req, ModelMap model, final RedirectAttributes redirectAttributes)
	{
		try
		{
			String oldPassword = req.getParameter("old");
			String newPassword = req.getParameter("new");
			if(!loginService.userValidated(gid, oldPassword))
			{
				model.addAttribute("message", "Old Password incorrect");
				return "change_password";
			}
			if(newPassword.contains(" "))
			{
				model.addAttribute("message", "Your password cannot contain space!");
				return "change_password";
			}
			loginService.updatePassword(gid, newPassword);
			
			redirectAttributes.addFlashAttribute("user", gid);
			if(loginService.getUserRole(gid).equals("manager"))
				return "redirect:userscreen_admin";
			
			setRedirectAttributes(gid, redirectAttributes);
			
			return "redirect:userscreen";
		}
		catch(Exception e)
		{
			return "hello";
		}
	}
	
	@RequestMapping(value = "/change", method = RequestMethod.GET)
	public String changeGet()
	{
 		return "hello";
	}
}