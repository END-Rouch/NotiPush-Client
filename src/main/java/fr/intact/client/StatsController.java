package fr.intact.client;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StatsController {

	@RequestMapping(value = "/subscription", method = RequestMethod.GET)
	public String subscriptionStats(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "subscription";

	}

	@RequestMapping(value = "/push", method = RequestMethod.GET)
	public String pushStats(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "push";

	}

	@RequestMapping(value = "/session", method = RequestMethod.GET)
	public String sessionStats(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "session";

	}

	@RequestMapping(value = "/install", method = RequestMethod.GET)
	public String installationStats(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "install";

	}

	@RequestMapping(value = "/launch", method = RequestMethod.GET)
	public String launchStats(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "launch";

	}

}