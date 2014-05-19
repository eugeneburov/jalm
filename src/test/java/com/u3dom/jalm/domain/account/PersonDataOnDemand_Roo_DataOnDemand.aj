// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.u3dom.jalm.domain.account;

import com.u3dom.jalm.domain.account.Person;
import com.u3dom.jalm.domain.account.PersonDataOnDemand;
import com.u3dom.jalm.domain.account.PersonRepository;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect PersonDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PersonDataOnDemand: @Component;
    
    private Random PersonDataOnDemand.rnd = new SecureRandom();
    
    private List<Person> PersonDataOnDemand.data;
    
    @Autowired
    PersonRepository PersonDataOnDemand.personRepository;
    
    public Person PersonDataOnDemand.getNewTransientPerson(int index) {
        Person obj = new Person();
        setEmail(obj, index);
        setFirstName(obj, index);
        setLastName(obj, index);
        return obj;
    }
    
    public void PersonDataOnDemand.setEmail(Person obj, int index) {
        String email = "foo" + index + "@bar.com";
        obj.setEmail(email);
    }
    
    public void PersonDataOnDemand.setFirstName(Person obj, int index) {
        String firstName = "firstName_" + index;
        obj.setFirstName(firstName);
    }
    
    public void PersonDataOnDemand.setLastName(Person obj, int index) {
        String lastName = "lastName_" + index;
        obj.setLastName(lastName);
    }
    
    public Person PersonDataOnDemand.getSpecificPerson(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Person obj = data.get(index);
        Long id = obj.getId();
        return personRepository.findOne(id);
    }
    
    public Person PersonDataOnDemand.getRandomPerson() {
        init();
        Person obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return personRepository.findOne(id);
    }
    
    public boolean PersonDataOnDemand.modifyPerson(Person obj) {
        return false;
    }
    
    public void PersonDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = personRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Person' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Person>();
        for (int i = 0; i < 10; i++) {
            Person obj = getNewTransientPerson(i);
            try {
                personRepository.save(obj);
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            personRepository.flush();
            data.add(obj);
        }
    }
    
}
