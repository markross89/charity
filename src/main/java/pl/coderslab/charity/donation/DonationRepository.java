package pl.coderslab.charity.donation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Optional;


@Repository
@Transactional
public interface DonationRepository extends JpaRepository<Donation, Long> {
	
	@Query(value = "SELECT SUM(quantity) FROM donation", nativeQuery = true)
	Optional<Integer> findQuantitySum ();

}
