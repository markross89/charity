package pl.coderslab.charity.donation;

import lombok.*;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.institution.Institution;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;


@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Donation {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private int quantity;
	private String postCode;
	private String street;
	private String city;
	private String pickUpComment;
	private LocalDate pickUpDate;
	private LocalTime pickUpTime;
	@OneToMany
	private List<Category> category;
	@OneToOne
	private Institution institution;
	
	
}
