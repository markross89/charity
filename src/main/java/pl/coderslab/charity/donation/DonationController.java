package pl.coderslab.charity.donation;


import com.google.common.collect.Lists;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import pl.coderslab.charity.category.CategoryRepository;

import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.user.CurrentUser;

import javax.validation.Valid;

import java.util.List;



@Controller
public class DonationController {
	
	private final static String VERIFICATION_EMAIL_SEND = "Dziękujemy za przesłanie formularza";
	private final CategoryRepository categoryRepository;
	private final InstitutionRepository institutionRepository;
	private final DonationRepository donationRepository;
	
	public DonationController (CategoryRepository categoryRepository, InstitutionRepository institutionRepository,
							   DonationRepository donationRepository) {
		
		this.categoryRepository = categoryRepository;
		this.institutionRepository = institutionRepository;
		this.donationRepository = donationRepository;
	}
	
	
	@GetMapping("/donation")
	public String displayForm (Model model) {
		
		model.addAttribute("categories", categoryRepository.findAll());
		model.addAttribute("institutions", institutionRepository.findByActiveTrue());
		model.addAttribute("donation", new Donation());
		return "donation/form";
	}
	
	@PostMapping("/donation")
	public String processForm (@Valid Donation donation, BindingResult result, Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		if (result.hasErrors()) {
			model.addAttribute("categories", categoryRepository.findAll());
			model.addAttribute("institutions", institutionRepository.findAll());
			return "donation/form";
		}
		if (customUser!=null) {
			donation.setUser(customUser.getUser());
		}
		donationRepository.save(donation);
		model.addAttribute("message", VERIFICATION_EMAIL_SEND);
		return "login/messageRegistration";
	}
	
	@GetMapping("/userDonations")
	public String displayDonations (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		List<List<Donation>> donations = Lists.partition(donationRepository.findAllByUserIdOrderByPickUpDateDesc(customUser.getUser().getId()), 2);
		model.addAttribute("user", customUser.getUser());
		model.addAttribute("donations", donations);
		return "donation/donations";
	}
	
	@GetMapping("/deleteDonation/{id}")
	public String deleteDonation (@PathVariable Long id) {
		
		donationRepository.delete(donationRepository.getById(id));
		return "redirect:/userDonations";
	}
	
	@GetMapping("/updateDonation/{id}")
	public String updateDonationForm (@PathVariable Long id, Model model) {
		
		model.addAttribute("categories", categoryRepository.findAll());
		model.addAttribute("institutions", institutionRepository.findByActiveTrue());
		model.addAttribute("donation", donationRepository.getById(id));
		return "donation/updateForm";
	}
	
	@PostMapping("/update")
	public String updateDonation (@Valid Donation donation, BindingResult result, Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		if (result.hasErrors()) {
			model.addAttribute("categories", categoryRepository.findAll());
			model.addAttribute("institutions", institutionRepository.findByActiveTrue());
			return "donation/updateForm";
		}
		donation.setUser(customUser.getUser());
		donationRepository.save(donation);
		model.addAttribute("message", VERIFICATION_EMAIL_SEND);
		return "login/messageRegistration";
	}
	
}
