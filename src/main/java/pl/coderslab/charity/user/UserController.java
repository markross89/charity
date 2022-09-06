package pl.coderslab.charity.user;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.institution.InstitutionRepository;

import javax.validation.Valid;


@Controller

public class UserController {
	
	private final UserService userService;
	private final InstitutionRepository institutionRepository;
	private final UserRepository userRepository;
	
	public UserController (UserService userService, InstitutionRepository institutionRepository, UserRepository userRepository) {
		
		this.userService = userService;
		this.institutionRepository = institutionRepository;
		this.userRepository = userRepository;
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
					return "/login/messageRegister";
				}
			}
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				userService.saveUser(user);
				model.addAttribute("user", user);
				return "login/messageRegistrationOk";
			}
		}
		return "login/register";
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


