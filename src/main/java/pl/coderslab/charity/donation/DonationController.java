package pl.coderslab.charity.donation;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;



@Controller
public class DonationController {
	
	
	@GetMapping("/donation")
	public String displayForm () {
		
		return "donation/form";
	}
	
	@PostMapping("/donation")
	public String processForm () {
		
		return "donation/form-confirmation";
	}
	
}
