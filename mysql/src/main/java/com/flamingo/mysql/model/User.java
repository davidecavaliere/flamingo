package com.flamingo.mysql.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.entity.RooJpaEntity;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.serializable.RooSerializable;
import org.springframework.roo.addon.tostring.RooToString;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import javax.persistence.Enumerated;

@RooJavaBean
@RooToString
@RooJpaEntity(table = "users")
@RooSerializable
@RooJson
public class User {

    /**
     */
    @NotNull
    @Column(name = "name")
    private String name;

    /**
     */
    @Enumerated
    private Gender gender;
}
