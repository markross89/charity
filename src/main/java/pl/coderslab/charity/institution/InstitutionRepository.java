package pl.coderslab.charity.institution;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;


@Repository
@Transactional
public interface InstitutionRepository extends JpaRepository<Institution, Long> {
	
	List<Institution> findByActiveTrue ();
	
	List<Institution> findAllByOrderByActiveDesc();
}
