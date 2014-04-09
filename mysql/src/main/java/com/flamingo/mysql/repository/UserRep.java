package com.flamingo.mysql.repository;
import com.flamingo.mysql.model.User;
import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;

@RooJpaRepository(domainType = User.class)
public interface UserRep {
}
