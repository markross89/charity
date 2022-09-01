package pl.coderslab.charity.user;

public interface UserService {
	
	User findByUserName (String name);
	
	void saveUser (User user);
	
	
}
