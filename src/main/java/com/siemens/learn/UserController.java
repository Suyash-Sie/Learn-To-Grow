package com.siemens.learn;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController 
{
	@RequestMapping(value = "/userscreen", method = RequestMethod.POST)
	public String welcome(ModelMap model) 
	{
		model.addAttribute("message", "Welcome to the learning app!");
		return "user";
	}
}
