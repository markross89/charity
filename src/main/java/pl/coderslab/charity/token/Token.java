package pl.coderslab.charity.token;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import pl.coderslab.charity.user.User;

import javax.persistence.*;
import java.time.LocalDateTime;


@NoArgsConstructor
@Getter
@Setter
@Entity
public class Token {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String token;
	private LocalDateTime expireTime;
	@OneToOne(cascade = {CascadeType.ALL})
	private User user;
	
	
	public Token (String token, User user) {
		
		this.token = token;
		this.user = user;
	}
}
