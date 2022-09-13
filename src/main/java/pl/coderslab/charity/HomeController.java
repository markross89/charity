package pl.coderslab.charity;

import com.google.common.collect.Lists;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.donation.DonationRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.InstitutionRepository;

import javax.servlet.http.HttpServletRequest;


@Controller
public class HomeController {
	
	private final InstitutionRepository institutionRepository;
	private final DonationRepository donationRepository;
	private final EmailServiceImpl emailService;
	private final MessageService messageService;
	
	public HomeController (InstitutionRepository institutionRepository, DonationRepository donationRepository, EmailServiceImpl emailService,
						   MessageService messageService) {
		
		this.institutionRepository = institutionRepository;
		this.donationRepository = donationRepository;
		this.emailService = emailService;
		this.messageService = messageService;
	}
	
	@RequestMapping("/")
	public String homeAction (Model model, HttpServletRequest request) {
		
		model.addAttribute("donations", donationRepository.findAll().size());
		model.addAttribute("quantity", donationRepository.findQuantitySum().orElse(0));
		model.addAttribute("list", Lists.partition(institutionRepository.findByActiveTrue(), 2));
		return "index";
	}
	
	@GetMapping("/sendEmail")
	public String sendEmail (@RequestParam String name, @RequestParam String surname, @RequestParam String message, Model model) {
		
		emailService.sendEmail("charityapp2000@gmail.com", name+" "+surname, message);
		model.addAttribute("message", messageService.getMessage("message.send"));
		return "login/messageRegistration";
	}
	
	
}
