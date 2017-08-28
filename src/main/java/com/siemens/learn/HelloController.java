package com.siemens.learn;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HelloController 
{
	private DBService dbService;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public HelloController()
	{
		dbService = new DBService();
		bCryptPasswordEncoder = new BCryptPasswordEncoder();
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
		LoginService loginService = new LoginService(dbService, bCryptPasswordEncoder);
		
		if(!loginService.userValidated(gid, password))
			return "hello";
		
		redirectAttributes.addFlashAttribute("user", gid);
		return "redirect:userscreen";
	}
}