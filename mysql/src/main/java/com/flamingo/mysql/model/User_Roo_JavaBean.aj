// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.flamingo.mysql.model;

import com.flamingo.mysql.model.Gender;
import com.flamingo.mysql.model.User;
import java.util.Date;

privileged aspect User_Roo_JavaBean {
    
    public String User.getName() {
        return this.name;
    }
    
    public void User.setName(String name) {
        this.name = name;
    }
    
    public Gender User.getGender() {
        return this.gender;
    }
    
    public void User.setGender(Gender gender) {
        this.gender = gender;
    }
    
    public Date User.getDateOfBirth() {
        return this.dateOfBirth;
    }
    
    public void User.setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
}
