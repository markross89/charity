package pl.coderslab.charity.donation;


import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import pl.coderslab.charity.category.CategoryRepository;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.user.CurrentUser;
import pl.coderslab.charity.user.User;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Controller
public class DonationController {
	
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
		model.addAttribute("institutions", institutionRepository.findAll());
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
		if(customUser!=null) {
			List<User> list = new ArrayList<>();
			list.add(customUser.getUser());
			donation.setUsers(list);
		}
		donationRepository.save(donation);
		return "donation/form-confirmation";
	}
	
}
