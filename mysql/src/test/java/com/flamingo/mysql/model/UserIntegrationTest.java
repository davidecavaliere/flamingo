package com.flamingo.mysql.model;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.roo.addon.test.RooIntegrationTest;

import com.googlecode.jcsv.reader.CSVReader;
import com.googlecode.jcsv.reader.internal.CSVReaderBuilder;

@RooIntegrationTest(entity = User.class)
public class UserIntegrationTest {
	
	private int maleUsersCount = 0;
	private int femaleUsersCount = 0;

	@SuppressWarnings("deprecation")
	@Before
	public void checkDatabaseNotEmpy() throws IOException {
		// clean the database
		userRep.deleteAllInBatch();
		
		//add dummy data
		String path = getClass().getResource("/dummydata.csv").getFile();		
		Reader reader = new FileReader(path);
		CSVReader<String[]> userReader = CSVReaderBuilder.newDefaultReader(reader);
		List<String[]> rUsers = userReader.readAll();
		
		for (String[] string : rUsers) {
			String[] userData = string[0].split(",");
			User user = new User();
			user.setName(userData[0]);
			user.setDateOfBirth(new Date(userData[2]));
			if (userData[2].equalsIgnoreCase("male")) {				
				user.setGender(Gender.MALE);
				maleUsersCount ++;
			} else {
				user.setGender(Gender.FEMALE);
				femaleUsersCount++;
			}
			
			userRep.save(user);
		}
				
		List<User> users = userRep.findAll();
		Assert.assertEquals(users.size(), rUsers.size());
	}
	
	@Test
	public void testFindUsersByGender() {
		List<User> users = userRep.findByGender(Gender.MALE);		
		Assert.assertEquals(users.size(), maleUsersCount);
	}
	
	@Test 
	public void testFindAllByDateOfBirth() {
		List<User> users = userRep.findAllOrderByDateOfBirth();
		User previusUser = null;
		for (User user : users) {
			if (previusUser!=null) {
				Assert.assertTrue(
					previusUser.getDateOfBirth().before(user.getDateOfBirth())
				);
			} else {
				previusUser = user;
			}
		}
	}
}
