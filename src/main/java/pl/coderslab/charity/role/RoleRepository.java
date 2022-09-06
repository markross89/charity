package pl.coderslab.charity.role;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.coderslab.charity.user.User;

import java.util.List;


@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
	Role findByName(String name);
	
	
	
}
