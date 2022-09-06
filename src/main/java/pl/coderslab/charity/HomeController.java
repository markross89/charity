package pl.coderslab.charity;

import com.google.common.collect.Lists;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.coderslab.charity.donation.DonationRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;

import java.util.List;


@Controller
public class HomeController {
    
    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;
    private final EmailServiceImpl emailService;
    
    public HomeController (InstitutionRepository institutionRepository, DonationRepository donationRepository, EmailServiceImpl emailService) {
    
        this.institutionRepository = institutionRepository;
        this.donationRepository = donationRepository;
        this.emailService = emailService;
    }
    
    
    @RequestMapping("/")
    public String homeAction(Model model){
      
      List<List<Institution>> couples = Lists.partition(institutionRepository.findAll(), 2);
      model.addAttribute("donations", donationRepository.findAll().size());
      model.addAttribute("quantity",donationRepository.findQuantitySum().orElse(0));
      model.addAttribute("list", couples);
      
        return "index";
    }
    
    @RequestMapping("/institutions")
    public String displayInstitutions(Model model){
        
        List<List<Institution>> couples = Lists.partition(institutionRepository.findAll(), 2);
        model.addAttribute("donations", donationRepository.findAll().size());
        model.addAttribute("quantity",donationRepository.findQuantitySum().orElse(0));
        model.addAttribute("list", couples);
        
        return "institutions";
    }
    
    @GetMapping ("/email")
    public String sendEmail(){
        emailService.sendEmail("anna.buczkowska2206@gmail.com", "jsfhsjfj", "kocham cię, miejmy romans");
        return "/index";
    }
    

}
