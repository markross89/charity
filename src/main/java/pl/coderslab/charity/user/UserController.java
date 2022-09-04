package pl.coderslab.charity.user;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.role.RoleRepository;


import javax.transaction.Transactional;
import javax.validation.Valid;



@Controller

public class UserController {
	
	private final UserService userService;
	private final RoleRepository roleRepository;
	private final UserRepository userRepository;
	
	public UserController (UserService userService, RoleRepository roleRepository, UserRepository userRepository) {
		
		this.userService = userService;
		this.roleRepository = roleRepository;
		this.userRepository = userRepository;
	}
	
	@GetMapping("/register")  // display register form
	public String showForm (Model model) {
		
		model.addAttribute("user", new User());
		return "/login/register";
	}
	
	@PostMapping("/register")  // adds a user
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


//	@GetMapping("/details")  // display details of  user
//	public String showUserDetails (Model model, @AuthenticationPrincipal CurrentUser customUser) {
//
//		model.addAttribute("user", customUser.getUser());
//		return "/login/userDetails";
//	}
////
//	@GetMapping("/profile")
//	public String userDetails (Model model, @AuthenticationPrincipal CurrentUser customUser) {
//
//		model.addAttribute("user", customUser.getUser());
//		return "/login/userDataUpdate";
//	}
//
//	@PostMapping("/profile")
//	public String saveUser (@Valid User user, BindingResult result) {
//
//		if (result.hasErrors()) {
//			return "/login/userDataUpdate";
//		}
//		else {
//			for (User u : userRepository.findAll()) {
//				if (u.getUsername().equals(user.getUsername())) {
//					return "/login/userDataUpdate";
//				}else {
//					userService.saveUser(user);
//					return "redirect:/userDetails";
//				}
//			}
//			return "redirect:/userDetails";
//		}
//	}
//
	
	@GetMapping("/profile")
	public String showProfile (Model model,  @AuthenticationPrincipal CurrentUser customUser) {
		
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
//	@GetMapping("/userList") // display users list
//	public String userList (Model model) {
//
//		model.addAttribute("users", userRepository.findAll());
//		return "/login/usersList";
//	}
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


