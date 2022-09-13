package pl.coderslab.charity.institution;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import pl.coderslab.charity.user.CurrentUser;

import javax.validation.Valid;


@Controller
public class InstitutionController {
	
	private final InstitutionRepository institutionRepository;
	private final InstitutionService institutionService;
	
	public InstitutionController (InstitutionRepository institutionRepository, InstitutionService institutionService) {
		
		this.institutionRepository = institutionRepository;
		this.institutionService = institutionService;
	}
	
	@GetMapping("/addInstitution")
	public String displayForm (Model model) {
		
		model.addAttribute("institution", new Institution());
		return "institution/form";
	}
	
	@PostMapping("/addInstitution")
	public String processForm (@Valid Institution institution, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "institution/form";
		}
		model.addAttribute("message", institutionService.addInstitution(institution));
		return "login/messageRegistration";
	}
	
	@GetMapping("/editInstitution/{id}")
	public String editInstitutionForm (@PathVariable Long id, Model model) {
		
		model.addAttribute("institution", institutionRepository.getById(id));
		return "institution/editForm";
	}
	
	@PostMapping("/editInstitution")
	public String processInstitutionForm (@Valid Institution institution, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "institution/editForm";
		}
		model.addAttribute("message", institutionService.updateInstitution(institution));
		return "redirect:/institutions";
	}
	
	@GetMapping("/institutions")
	public String institutionList (Model model, @AuthenticationPrincipal CurrentUser customUser) {
		
		model.addAttribute("user", customUser.getUser());
		model.addAttribute("institutions", institutionRepository.findAllByOrderByActiveDesc());
		return "/user/institutions";
	}
}
