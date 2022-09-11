package pl.coderslab.charity.registration;

import org.springframework.stereotype.Service;
import pl.coderslab.charity.token.Token;
import pl.coderslab.charity.token.TokenService;
import pl.coderslab.charity.user.User;
import pl.coderslab.charity.user.UserRepository;
import pl.coderslab.charity.user.UserService;

import java.time.LocalDateTime;


@Service
public class RegistrationService {
	
	private final static String SOMETHING_WENT_WRONG = "Przykro nam<br>Coś poszło nie tak<br> Pamiętaj że podane hasła muszą być takie same.";
	private final static String SORRY_EMAIL_EXISTS = "Przykro nam<br> Wygląda na to że podany email istnieje już w naszej bazie danych.<br> Spróbuj"+
			" się "+
			"zalogować, lub użyć innego adresu email.";
	private final static String SUCCESSFUL_REGISTRATION = "Gratulacje ! <br>Link do weryfikacji konta został wysłany na podany przez ciebie email"+
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
	
	public String registerUser (User user) {
		
		for (User u : userRepository.findAll()) {
			if (u.getUsername().equals(user.getUsername())) {
				return SORRY_EMAIL_EXISTS;
			}
		}
		if (user.getPassword().equals(user.getPasswordRepeat())) {
			userService.saveUser(user, false);
			return SUCCESSFUL_REGISTRATION;
		}
		return SOMETHING_WENT_WRONG;
	}
	
	public String emailConfirmation (String token) {
		
		Token newToken = tokenService.findByToken(token);
		if (newToken == null) {
			return TOKEN_BROKEN;
		}
		else {
			LocalDateTime time = LocalDateTime.now();
			LocalDateTime expirationTime = newToken.getExpireTime();
			if (expirationTime.isBefore(time)) {
				return TOKEN_EXPIRED;
			}
			else {
				User user = tokenService.findByToken(token).getUser();
				if (user.getEnabled() == 0) {
					user.setEnabled(1);
					userRepository.save(user);
					return VERIFICATION_SUCCESS;
				}
				else {
					return VERIFICATION_ALREADY_DONE;
				}
			}
		}
	}
}
