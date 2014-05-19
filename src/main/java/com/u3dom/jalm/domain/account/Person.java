package com.u3dom.jalm.domain.account;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Person {

    /**
     */
    @NotNull
    @Size(min = 1)
    private String firstName;

    /**
     */
    private String lastName;

    /**
     */
    @NotNull
    @Size(min = 3)
    private String email;
}
