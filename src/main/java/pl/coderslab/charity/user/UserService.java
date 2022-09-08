package pl.coderslab.charity.user;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.role.Role;
import pl.coderslab.charity.role.RoleRepository;
import pl.coderslab.charity.token.TokenService;

import java.util.HashSet;
import java.util.List;
import java.util.UUID;


@Service
public class UserService  {
	
	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final BCryptPasswordEncoder passwordEncoder;
	private final TokenService tokenService;
	private final EmailServiceImpl emailService;
	
	public UserService (UserRepository userRepository, RoleRepository roleRepository,
						BCryptPasswordEncoder passwordEncoder, TokenService tokenService, EmailServiceImpl emailService) {
		
		this.passwordEncoder = passwordEncoder;
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.tokenService = tokenService;
		this.emailService = emailService;
	}
	

	public User findByUsername (String username) {
		
		return userRepository.findByUsername(username);
	}
	
	
	public void saveUser (User user, boolean enable) {
		
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		enableUser(user,enable);
		Role userRole = roleRepository.findByName("ROLE_USER");
		user.setRoles(new HashSet<>(List.of(userRole)));
		
		try{
			String token = UUID.randomUUID().toString();
			tokenService.saveToken(token, user);
	
			String body = "Aby dokończyć rejestracje, proszę kliknąć w link w celu potwierdzenia adresu email i aktywacji konta: "+"http" +
					"://localhost" +
					":8080/confirm?token="+token;
			emailService.sendEmail(user.getUsername(), "Weryfikacja adresu email do charityapp2000", body);
			
		}catch(Exception e){
			e.printStackTrace();
		};
		
		userRepository.save(user);
	}
	
	public void enableUser(User user, boolean enable){
		if(enable){user.setEnabled(1);}else{user.setEnabled(0);}
	}

}


