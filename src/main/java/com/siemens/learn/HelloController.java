package com.siemens.learn;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String printHello(ModelMap model) 
	{
		model.addAttribute("message", "Hello Spring MVC Framework!");
		return "hello";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(ModelMap model, @RequestParam String gid, @RequestParam String password, final RedirectAttributes redirectAttributes) 
	{
		this.gid = gid;
		try
		{
			if(!loginService.userValidated(gid, password))
				return "hello";
			else if(!loginService.hasUserChangedPassword(gid))
				return "change_password";
			
			redirectAttributes.addFlashAttribute("user", gid);
			redirectAttributes.addFlashAttribute("quarter", "Quarter 1");
			
			if(loginService.getUserRole(gid).equals("manager"))
				return "redirect:userscreen_admin";
			
			return "redirect:userscreen";
		}
		catch(Exception e)
		{
			return "hello";
		}
	}
	
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest req, ModelMap model)
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
			loginService.updatePassword(gid, newPassword);
			return "redirect:userscreen";
		}
		catch(Exception e)
		{
			return "hello";
		}
	}
}