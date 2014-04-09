// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.flamingo.mysql.model;

import com.flamingo.mysql.model.UserDataOnDemand;
import com.flamingo.mysql.model.UserIntegrationTest;
import com.flamingo.mysql.repository.UserRep;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect UserIntegrationTest_Roo_IntegrationTest {
    
    declare @type: UserIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: UserIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: UserIntegrationTest: @Transactional;
    
    @Autowired
    UserDataOnDemand UserIntegrationTest.dod;
    
    @Autowired
    UserRep UserIntegrationTest.userRep;
    
    @Test
    public void UserIntegrationTest.testCount() {
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", dod.getRandomUser());
        long count = userRep.count();
        Assert.assertTrue("Counter for 'User' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void UserIntegrationTest.testFind() {
        User obj = dod.getRandomUser();
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'User' failed to provide an identifier", id);
        obj = userRep.findOne(id);
        Assert.assertNotNull("Find method for 'User' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'User' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void UserIntegrationTest.testFindAll() {
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", dod.getRandomUser());
        long count = userRep.count();
        Assert.assertTrue("Too expensive to perform a find all test for 'User', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<User> result = userRep.findAll();
        Assert.assertNotNull("Find all method for 'User' illegally returned null", result);
        Assert.assertTrue("Find all method for 'User' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void UserIntegrationTest.testFindEntries() {
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", dod.getRandomUser());
        long count = userRep.count();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<User> result = userRep.findAll(new org.springframework.data.domain.PageRequest(firstResult / maxResults, maxResults)).getContent();
        Assert.assertNotNull("Find entries method for 'User' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'User' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void UserIntegrationTest.testFlush() {
        User obj = dod.getRandomUser();
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'User' failed to provide an identifier", id);
        obj = userRep.findOne(id);
        Assert.assertNotNull("Find method for 'User' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyUser(obj);
        Integer currentVersion = obj.getVersion();
        userRep.flush();
        Assert.assertTrue("Version for 'User' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void UserIntegrationTest.testSaveUpdate() {
        User obj = dod.getRandomUser();
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'User' failed to provide an identifier", id);
        obj = userRep.findOne(id);
        boolean modified =  dod.modifyUser(obj);
        Integer currentVersion = obj.getVersion();
        User merged = userRep.save(obj);
        userRep.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'User' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void UserIntegrationTest.testSave() {
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", dod.getRandomUser());
        User obj = dod.getNewTransientUser(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'User' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'User' identifier to be null", obj.getId());
        try {
            userRep.save(obj);
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        userRep.flush();
        Assert.assertNotNull("Expected 'User' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void UserIntegrationTest.testDelete() {
        User obj = dod.getRandomUser();
        Assert.assertNotNull("Data on demand for 'User' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'User' failed to provide an identifier", id);
        obj = userRep.findOne(id);
        userRep.delete(obj);
        userRep.flush();
        Assert.assertNull("Failed to remove 'User' with identifier '" + id + "'", userRep.findOne(id));
    }
    
}