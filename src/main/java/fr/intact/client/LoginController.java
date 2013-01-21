package fr.intact.client;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {

	@RequestMapping(value = "/mainPage", method = RequestMethod.GET)
	public String loginSuccess(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "main";

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap model) {

		model.addAttribute("appName", "Noti-Push");
		return "login";

	}

	@RequestMapping(value = "/loginfailed", method = RequestMethod.GET)
	public String loginerror(ModelMap model) {

		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("error", "true");
		return "login";

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {

		model.addAttribute("appName", "Noti-Push");
		return "login";

	}

}