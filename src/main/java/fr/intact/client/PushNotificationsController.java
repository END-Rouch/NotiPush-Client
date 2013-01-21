package fr.intact.client;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PushNotificationsController {

	@RequestMapping(value = "/composePush", method = RequestMethod.GET)
	public String pushComposer(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "composePush";

	}
	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public String pushHistory(ModelMap model, Principal principal) {

		String name = principal.getName();

		model.addAttribute("userName", name);
		model.addAttribute("appName", "Noti-Push");
		model.addAttribute("logout", "Logout");
		return "history";

	}
	

}