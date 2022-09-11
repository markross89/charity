package pl.coderslab.charity.user;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.coderslab.charity.role.Role;
import pl.coderslab.charity.role.RoleRepository;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;


@Service
public class UserService {
	
	
	private final static String TOKEN_BROKEN = "Token weryfikacyjny jest błędny.";
	private final static String TOKEN_EXPIRED = "Token weryfikacyjny wygasł.";
	private final static String REGISTRATION_MESSAGE = "Aby dokończyć rejestracje, proszę kliknąć w link w celu potwierdzenia adresu email i "+
			"aktywacji konta: ";
	private final static String REGISTRATION_LINK = "http://localhost:8080/confirm?token=";
	private final static String REGISTRATION_SUBJECT = "Weryfikacja adresu email do charityapp2000";
	private final static String UPDATE_USER_FAIL = "Podane hasła muszą być takie same.";
	private final static String UPDATE_USER_SUCCESS = "Edycja zakończona sukcesem.";
	private final static String CHANGE_PASSWORD_MESSAGE = "Aby zmienić hasło na nowe proszę kliknąć w podany link: ";
	private final static String CHANGE_PASSWORD_LINK = "http://localhost:8080/password?token=";
	private final static String CHANGE_PASSWORD_SUBJECT = "Zmiana hasła charityapp2000";
	private final static String CHANGE_PASSWORD_EMAIL_NOT_EXIST = "Podany adres email nie istnieje w bazie danych.<br>Proszę podać inny adres";
	private final static String CHANGE_PASSWORD_SUCCESS = "Link umożliwiający zmianę hasła został wysłany na podany adres email.<br>Link będzie "+
			"ważny przez 20 minut";
	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final BCryptPasswordEncoder passwordEncoder;
	private final TokenService tokenService;
	
	
	public UserService (UserRepository userRepository, RoleRepository roleRepository,
						BCryptPasswordEncoder passwordEncoder, TokenService tokenService) {
		
		this.passwordEncoder = passwordEncoder;
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.tokenService = tokenService;
	}
	
	
	public User findByUsername (String username) {
		
		return userRepository.findByUsername(username);
	}
	
	
	public void saveUser (User user, boolean enable) {
		
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		enableUser(user, enable);
		Role userRole = roleRepository.findByName("ROLE_USER");
		user.setRoles(new HashSet<>(List.of(userRole)));
		tokenService.createAndSendToken(user, REGISTRATION_MESSAGE, REGISTRATION_LINK, REGISTRATION_SUBJECT);
		userRepository.save(user);
	}
	
	public void enableUser (User user, boolean enable) {
		
		if (enable) {user.setEnabled(1);}
		else {user.setEnabled(0);}
	}
	
	public String updateUser (User user) {
		
		if (user.getPassword().equals(user.getPasswordRepeat())) {
			saveUser(user, true);
			return UPDATE_USER_SUCCESS;
		}
		return UPDATE_USER_FAIL;
	}
	
	public String verifyUserExists (String username) {
		
		User user = userRepository.findByUsername(username);
		if (user != null) {
			tokenService.createAndSendToken(user, CHANGE_PASSWORD_MESSAGE, CHANGE_PASSWORD_LINK, CHANGE_PASSWORD_SUBJECT);
			return CHANGE_PASSWORD_SUCCESS;
		}
		else {
			return CHANGE_PASSWORD_EMAIL_NOT_EXIST;
		}
	}
	
	public String passwordChangeConfirmation (String token) {
		
		Token newToken = tokenService.findByToken(token);
		if (newToken == null) {
			return TOKEN_BROKEN;
		}
		LocalDateTime time = LocalDateTime.now();
		LocalDateTime expirationTime = newToken.getExpireTime();
		if (expirationTime.isBefore(time)) {
			return TOKEN_EXPIRED;
		}
		return token;
	}
	
	public String updateUserPassword (User user) {
		
		if (user.getPassword().equals(user.getPasswordRepeat())) {
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			userRepository.save(user);
			return UPDATE_USER_SUCCESS;
		}
		return UPDATE_USER_FAIL;
	}
}


