// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.flamingo.mysql.repository;

import com.flamingo.mysql.model.User;
import com.flamingo.mysql.repository.UserRep;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

privileged aspect UserRep_Roo_Jpa_Repository {
    
    declare parents: UserRep extends JpaRepository<User, Long>;
    
    declare parents: UserRep extends JpaSpecificationExecutor<User>;
    
    declare @type: UserRep: @Repository;
    
}