package com.siemens.learn;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HelloController 
{
	@RequestMapping(value = "/hello", method = RequestMethod.GET)
	public String printHello(ModelMap model) 
	{
		model.addAttribute("message", "Hello Spring MVC Framework!");
		return "hello";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(ModelMap model, @RequestParam String name, @RequestParam String password, final RedirectAttributes redirectAttributes) 
	{
		LoginService service = new LoginService();
		if(service.userValidated(name, password))
		{
			redirectAttributes.addFlashAttribute("user", name);
			return "redirect:userscreen";
		}
		return "hello";
	}
}