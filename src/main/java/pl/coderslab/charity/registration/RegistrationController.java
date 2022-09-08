package pl.coderslab.charity.registration;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;
import pl.coderslab.charity.user.User;
import pl.coderslab.charity.user.UserRepository;
import pl.coderslab.charity.user.UserService;

import javax.validation.Valid;
import java.time.LocalDateTime;


@Controller
public class RegistrationController {
	
	private final UserRepository userRepository;
	private final UserService userService;
	private final TokenService tokenService;
	private final RegistrationService registrationService;
	
	public RegistrationController (UserRepository userRepository, UserService userService, TokenService tokenService,
								   RegistrationService registrationService) {
		
		this.userRepository = userRepository;
		this.userService = userService;
		this.tokenService = tokenService;
		this.registrationService = registrationService;
	}
	
	
	@GetMapping("/register")
	public String showRegistrationForm (Model model) {
		
		model.addAttribute("user", new User());
		return "/login/register";
	}
	
	@PostMapping("/register")
	public String processRegistrationForm (@Valid User user, BindingResult result, Model model) {
		
		return	registrationService.registerUser(user, model, result);
	}
	
	@GetMapping("/confirm")
	public String emailConfirmation (@RequestParam String token, Model model) {
		
		registrationService.emailConfirmation(token, model);
		return "login/messageRegistration";
	}
	
}
