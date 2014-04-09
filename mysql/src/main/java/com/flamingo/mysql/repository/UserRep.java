package com.flamingo.mysql.repository;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;

import com.flamingo.mysql.model.Gender;
import com.flamingo.mysql.model.User;

@RooJpaRepository(domainType = User.class)
public interface UserRep {
	
	/**
	 * Find users by gender
	 * @param gender
	 * @return List of users
	 */
	List<User> findByGender(Gender gender);
	
	@Query("select distinct u from User as u order by u.dateOfBirth ASC")
	List<User> findAllOrderByDateOfBirth();
}
