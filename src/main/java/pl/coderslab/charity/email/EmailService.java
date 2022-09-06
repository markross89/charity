package pl.coderslab.charity.email;

public interface EmailService {
	void sendEmail(String to, String subject, String message);

}
