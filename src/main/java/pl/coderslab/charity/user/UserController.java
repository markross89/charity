package pl.coderslab.charity.user;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.email.EmailService;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.role.RoleRepository;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.UUID;


@Controller

public class UserController {
	
	private final UserService userService;
	private final UserRepository userRepository;
	private final TokenService tokenService;
	private final RoleRepository roleRepository;
	private final EmailServiceImpl emailService;
	private final BCryptPasswordEncoder passwordEncoder;
	
	public UserController (UserService userService, UserRepository userRepository,
						   TokenService tokenService, RoleRepository roleRepository, EmailServiceImpl emailService,
						   BCryptPasswordEncoder passwordEncoder) {
		
		this.userService = userService;
		this.userRepository = userRepository;
		this.tokenService = tokenService;
		this.roleRepository = roleRepository;
		this.emailService = emailService;
		this.passwordEncoder = passwordEncoder;
	}
	
	
	
	@GetMapping("/profile")
	public String showProfile (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		model.addAttribute("user", customUser.getUser());
		return "/login/userDataUpdate";
	}
	
	@PostMapping("/profile")
	public String updateUser (@Valid User user, BindingResult result, Model model) {
		
		if (!result.hasErrors()) {
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				userService.saveUser(user, true);
				model.addAttribute("message", "Edycja zakończona sukcesem.");
				return "login/messageRegistration";
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
	
	@GetMapping("/editCredentials/{id}")
	public String editCredentials (@PathVariable Long id, Model model) {
		
		model.addAttribute("user", userRepository.findById(id).get());
		model.addAttribute("roles", roleRepository.findAll());
		return "/user/editCredentials";
	}
	
	@PostMapping("/editCredentials")
	public String saveCredentials (@Valid User user, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			model.addAttribute("roles", roleRepository.findAll());
			return "/user/editCredentials";
		}
		userRepository.save(user);
		return "redirect:/admin";
	}
	
	@PostMapping("/changePassword")
	public String sendLink (@RequestParam String username, Model model) {
		
		if (userRepository.findByUsername(username) != null) {
			
			try {
				String token = UUID.randomUUID().toString();
				tokenService.saveToken(token, userRepository.findByUsername(username));
				
				String body = "Aby zmienić hasło na nowe proszę kliknąć w podany link: "+"http"+
						"://localhost"+
						":8080/password?token="+token;
				emailService.sendEmail(username, "Zmiana hasła charityapp2000", body);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			model.addAttribute("message", "Podany adres email nie istnieje w bazie danych.<br>Proszę podać inny adres");
			return "login/messageRegistration";
		}
		model.addAttribute("message", "Link umożliwiający zmianę hasła został wysłany na podany adres email.<br>"+
				"Link będzie ważny przez 20 minut");
		return "login/messageRegistration";
	}
	
	@GetMapping("/password")
	public String passwordForm (@RequestParam String token, Model model) {

		Token verificationToken = tokenService.findByToken(token);
		if (verificationToken == null) {
			model.addAttribute("message", "Token weryfikacyjny jest błędny.");
			return "login/messageRegistration";
		}
		else {
			LocalDateTime time = LocalDateTime.now();
			LocalDateTime expirationTime = verificationToken.getExpireTime();
			if (expirationTime.isBefore(time)) {
				model.addAttribute("message", "Token weryfikacyjny wygasł.");
				return "login/messageRegistration";
			}
			else {
				model.addAttribute("user", tokenService.findByToken(token).getUser());
				return "/login/passwordUpdate";
			}
		}
	}
	
	@PostMapping("/password")
	public String passwordReset (@Valid User user, BindingResult result, Model model) {

		if (result.hasErrors()) {
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				user.setPassword(passwordEncoder.encode(user.getPassword()));
				userRepository.save(user);
				model.addAttribute("message", "Zmiana hasła zakończona sukcesem.");
				return "login/messageRegistration";
			}
		}
		return "/login/passwordUpdate";
	}
}