package pl.coderslab.charity.user;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;

import javax.validation.Valid;
import java.time.LocalDateTime;


@Controller

public class UserController {
	
	private final UserService userService;
	private final InstitutionRepository institutionRepository;
	private final UserRepository userRepository;
	private final TokenService tokenService;
	
	public UserController (UserService userService, InstitutionRepository institutionRepository, UserRepository userRepository,
						   TokenService tokenService) {
		
		this.userService = userService;
		this.institutionRepository = institutionRepository;
		this.userRepository = userRepository;
		this.tokenService = tokenService;
	}
	
	@GetMapping("/register")
	public String showForm (Model model) {
		
		model.addAttribute("user", new User());
		return "/login/register";
	}
	
	@PostMapping("/register")
	public String processForm (@Valid User user, BindingResult result, Model model) {
		
		if (!result.hasErrors()) {
			for (User u : userRepository.findAll()) {
				if (u.getUsername().equals(user.getUsername())) {
					model.addAttribute("message", "Przykro nam<br> Wygląda na to że podany email istnieje już w naszej bazie danych.<br> Spróbuj " +
							"się " +
							"zalogować, lub użyć innego adresu email.");
					return "/login/messageRegistration";
				}
			}
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				userService.saveUser(user);
				model.addAttribute("message", "Gratulacje ! <br>link do weryfikacji konta został wysłany na podany przez ciebie email.<br> " +
						"Potwierdź " +
						"go w ciągu 20 minut aby uaktywnić konto.");
				return "login/messageRegistration";
			}
		}
		return "login/register";
	}
	
	@GetMapping("/confirm")
	public String emailConfirmation(@RequestParam String token, Model model){
		Token verificationToken = tokenService.findByToken(token);
		if (verificationToken==null){
		model.addAttribute("message", "Token weryfikacyjny jest błędny.");
		}else{
			User user = verificationToken.getUser();
			if(user.getEnabled()==0){
				LocalDateTime time = LocalDateTime.now();
				LocalDateTime expirationTime = verificationToken.getExpireTime();
				if(expirationTime.isBefore(time)){
					model.addAttribute("message", "Token weryfikacyjny wygasł.");
				}else{
					user.setEnabled(1);
					userRepository.save(user);
					model.addAttribute("message", "Weryfikacja zakończona sukcesem.");
				}
			}else{
				model.addAttribute("message", "Twój email został już zweryfikowany.");
			}
		}
		return "login/messageRegistration";
	}
	
	@GetMapping("/profile")
	public String showProfile (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		model.addAttribute("user", customUser.getUser());
		return "/login/userDataUpdate";
	}
	
	@PostMapping("/profile")
	public String updateUser (@Valid User user, BindingResult result) {
		
		if (!result.hasErrors()) {
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				userService.saveUser(user);
				
				return "redirect:/profile";
			}
		}
		return "/login/userDataUpdate";
	}
	
	@GetMapping("/admin")
	public String userList (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		model.addAttribute("user", customUser.getUser());
		model.addAttribute("users", userRepository.findAll());
		return "/user/admin";
	}
	
	@GetMapping("/institutions")
	public String institutionList (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		model.addAttribute("user", customUser.getUser());
		model.addAttribute("institutions", institutionRepository.findAll());
		return "/user/institutions";
	}


//
//	@GetMapping("/changeRole/{id}")  // display user role form
//	public String roleForm (Model model, @PathVariable long id) {
//
//		model.addAttribute("user", id);
//		model.addAttribute("roles", roleRepository.findAll());
//		return "/login/roleForm";
//	}
//
//	@PostMapping("/changeRole/{id}")  // update users role
//	public String updateRole (@PathVariable long id, @RequestParam String role) {
//
//		User user = userRepository.findById(id).get();
//		Set<Role> roles = new HashSet<>();
//		roles.add(roleRepository.findByName(role));
//		user.setRoles(roles);
//		userRepository.save(user);
//		return "redirect:/user/userList";
//	}
}


