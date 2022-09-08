package pl.coderslab.charity.registration;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;
import pl.coderslab.charity.user.User;
import pl.coderslab.charity.user.UserRepository;
import pl.coderslab.charity.user.UserService;

import java.time.LocalDateTime;


@Service
public class RegistrationService {
	
	private final static String SORRY_EMAIL_EXISTS = "Przykro nam<br> Wygląda na to że podany email istnieje już w naszej bazie danych.<br> Spróbuj" +
			" się "+
			"zalogować, lub użyć innego adresu email.";
	private final static String SUCCESSFUL_REGISTRATION = "Gratulacje ! <br>Link do weryfikacji konta został wysłany na podany przez ciebie email" +
			".<br> Potwierdź go w ciągu 20 minut aby uaktywnić konto.";
	private final static String TOKEN_BROKEN = "Token weryfikacyjny jest błędny.";
	private final static String TOKEN_EXPIRED = "Token weryfikacyjny wygasł.";
	private final static String VERIFICATION_SUCCESS = "Weryfikacja zakończona sukcesem.";
	private final static String VERIFICATION_ALREADY_DONE = "Twój email został już zweryfikowany.";
	private final UserRepository userRepository;
	private final UserService userService;
	private final TokenService tokenService;
	
	
	public RegistrationService (UserRepository userRepository, UserService userService, TokenService tokenService) {
		
		this.userRepository = userRepository;
		this.userService = userService;
		this.tokenService = tokenService;
	}
	
	public String registerUser (User user, Model model, BindingResult result) {
		
		if (!result.hasErrors()) {
			for (User u : userRepository.findAll()) {
				if (!u.getUsername().equals(user.getUsername())) {
					model.addAttribute("message", SORRY_EMAIL_EXISTS);
					return "/login/messageRegistration";
				}
			}
			if (user.getPassword().equals(user.getPasswordRepeat())) {
				userService.saveUser(user, false);
				model.addAttribute("message", SUCCESSFUL_REGISTRATION);
				return "login/messageRegistration";
			}
		}
		return "login/register";
	}
	
	public void emailConfirmation (String token, Model model) {
		
		Token verificationToken = tokenService.findByToken(token);
		if (verificationToken == null) {
			model.addAttribute("message", TOKEN_BROKEN);
		}
		else {
			User user = verificationToken.getUser();
			if (user.getEnabled() == 0) {
				LocalDateTime time = LocalDateTime.now();
				LocalDateTime expirationTime = verificationToken.getExpireTime();
				if (expirationTime.isBefore(time)) {
					model.addAttribute("message", TOKEN_EXPIRED);
				}
				else {
					user.setEnabled(1);
					userRepository.save(user);
					model.addAttribute("message", VERIFICATION_SUCCESS);
				}
			}
			else {
				model.addAttribute("message", VERIFICATION_ALREADY_DONE);
			}
		}
	}
}
