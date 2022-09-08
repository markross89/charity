package pl.coderslab.charity.token;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.coderslab.charity.user.User;

import javax.transaction.Transactional;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;



@Service
public class TokenService {
	
	private final TokenRepository tokenRepository;
	
	@Autowired
	public TokenService (TokenRepository tokenRepository) {
		
		this.tokenRepository = tokenRepository;
	}
	
	@Transactional
	public Token findByToken (String token) {
		
		return tokenRepository.findByToken(token);
	}
	
	@Transactional
	public void saveToken (String token, User user) {
		
		Token activationToken = new Token(token, user);
		activationToken.setExpireTime(calculateExpiryTime(20));
		tokenRepository.save(activationToken);
	}
	
	private LocalDateTime calculateExpiryTime (int minutes) {
		
		return LocalDateTime.now().plus(Duration.of(minutes, ChronoUnit.MINUTES));
	}
	

}
