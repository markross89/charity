package pl.coderslab.charity.donation;

import org.springframework.stereotype.Service;
import pl.coderslab.charity.MessageService;
import pl.coderslab.charity.user.CurrentUser;


import java.util.Optional;


@Service
public class DonationService {
	
	private final DonationRepository donationRepository;
	private final MessageService messageService;
	
	public DonationService (DonationRepository donationRepository, MessageService messageService) {
		
		this.donationRepository = donationRepository;
		this.messageService = messageService;
	}
	
	public String addDonation (Donation donation, CurrentUser user) {
		
		if(Optional.ofNullable(user).isPresent()){
			donation.setUser(user.getUser());
		}
		donationRepository.save(donation);
		return messageService.getMessage("donation.email");
	}
}

