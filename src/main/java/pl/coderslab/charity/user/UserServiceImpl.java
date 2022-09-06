package pl.coderslab.charity.user;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.role.Role;
import pl.coderslab.charity.role.RoleRepository;
import pl.coderslab.charity.token.TokenService;

import java.util.Arrays;
import java.util.HashSet;
import java.util.UUID;


@Service
public class UserServiceImpl implements UserService {
	
	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final BCryptPasswordEncoder passwordEncoder;
	private final TokenService tokenService;
	private final EmailServiceImpl emailService;
	
	public UserServiceImpl (UserRepository userRepository, RoleRepository roleRepository,
							BCryptPasswordEncoder passwordEncoder, TokenService tokenService, EmailServiceImpl emailService) {
		
		this.passwordEncoder = passwordEncoder;
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.tokenService = tokenService;
		this.emailService = emailService;
	}
	
	@Override
	public User findByUserName (String username) {
		
		return userRepository.findByUsername(username);
	}
	
	@Override
	public void saveUser (User user) {
		
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		user.setEnabled(0);
		Role userRole = roleRepository.findByName("ROLE_USER");
		user.setRoles(new HashSet<>(Arrays.asList(userRole)));
		
		try{
			String token = UUID.randomUUID().toString();
			tokenService.saveToken(token, user);
	
			String body = "Aby dokończyć rejestracje, proszę kliknąć w link w celu potwierdzenia adresu email i aktywacji konta: "+"http" +
					"://localhost" +
					":8080/confirm?token="+token;
			emailService.sendEmail(user.getUsername(), "email address verification", body);
			
		}catch(Exception e){
			e.printStackTrace();
		};
		
		userRepository.save(user);
	}

}


