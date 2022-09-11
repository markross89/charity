package pl.coderslab.charity.donation;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import pl.coderslab.charity.user.User;
import pl.coderslab.charity.validator.DateFuture;
import pl.coderslab.charity.validator.ZipCode;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.institution.Institution;

import javax.persistence.*;
import javax.validation.constraints.*;
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
	@NotNull
	@Min(1)
	private int quantity;
	@NotBlank
	@ZipCode
	private String postCode;
	@Size(min = 3)
	@NotBlank
	private String street;
	@Size(min = 3)
	@NotBlank
	private String city;
	private String pickUpComment;
	@NotNull
	@DateFuture
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate pickUpDate;
	@NotNull
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime pickUpTime;
	@NotEmpty
	@ManyToMany
	private List<Category> category;
	@NotNull
	@ManyToOne
	private Institution institution;
	@ManyToOne
	private User user;
	
	
}
