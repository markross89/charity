package pl.coderslab.charity.institution;

import org.springframework.stereotype.Service;
import pl.coderslab.charity.MessageService;


@Service
public class InstitutionService {
	
	private final InstitutionRepository institutionRepository;
	private final MessageService messageService;
	
	public InstitutionService (InstitutionRepository institutionRepository, MessageService messageService) {
		
		this.institutionRepository = institutionRepository;
		this.messageService = messageService;
	}
	
	public String addInstitution(Institution institution){
		
		institution.setActive(true);
		institutionRepository.save(institution);
		return messageService.getMessage("institution.add.success");
	}
	
	public String updateInstitution(Institution institution){
		
		institutionRepository.save(institution);
		return messageService.getMessage("institution.update.success");
	}

}
