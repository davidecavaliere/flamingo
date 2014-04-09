package com.flamingo.mvc;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.Days;
import org.joda.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.flamingo.mysql.model.Gender;
import com.flamingo.mysql.model.User;
import com.flamingo.mysql.repository.UserRep;
import com.googlecode.jcsv.reader.CSVReader;
import com.googlecode.jcsv.reader.internal.CSVReaderBuilder;

@Controller
@RequestMapping("/")
public class IndexController {

	@Autowired
	UserRep userRep;
	
	@RequestMapping("")
	public ModelAndView indexAction(HttpServletRequest req, @RequestParam(value = "result", required = false) String result) {
		ModelAndView mav = new ModelAndView("index");
		
		if (result != null) {
			mav.addObject("result", result);
		}
		
		/*
		 * getting the oldest user should be done in another way
		 * due to the lack of time I feel this solution suitable
		 * for the purpose of this test
		 */
		List<User> users = userRep.findAllOrderByDateOfBirth();
		
		mav.addObject("users", users);
		
		if (users.size()>0) {			
			mav.addObject("oldest", users.get(0));
		}
		
		User bill = userRep.findByName("Bill McKnight");
		User paul = userRep.findByName("Paul Robinson");
		if (bill!=null && paul!=null) {			
			String diffAge = getDiffAge(bill, paul);
			
			mav.addObject("diffAge", diffAge);
		}
		
		return mav;
	}
	
	private String getDiffAge(User user1, User user2) {
		LocalDate date1 = new LocalDate(user1.getDateOfBirth());
		LocalDate date2 = new LocalDate(user2.getDateOfBirth());

		String diffDays = Days.daysBetween(date1, date2).toString();
		
		return diffDays.substring(1, diffDays.length()-1);
	}

	@RequestMapping(value="upload", method=RequestMethod.GET)
    public @ResponseBody String provideUploadInfo() {
        return "You can upload a file by posting to this same URL.";
    }

    @RequestMapping(value="upload", method=RequestMethod.POST)
    public ModelAndView handleFileUpload(@RequestParam("file") MultipartFile file){
    	ModelAndView mav = new ModelAndView("redirect:");    	
    	/*
    	 * TODO: improve filetype check
    	 */
    	if (!file.isEmpty()) {    		
    		String name = file.getOriginalFilename();            
    		if (file.getOriginalFilename().endsWith("csv")) {
    			String tmpFolder = System.getProperty("java.io.tmpdir");
    			File tmpFile = new File(tmpFolder + File.separator + name);
    			try {
					file.transferTo(tmpFile);
					importUsers(tmpFile);    			
					mav.addObject("result", name + " uploaded successfuly");
				} catch (Exception e) { 
					mav.addObject("result", name + " error processing the file. Please try again");
					e.printStackTrace();
				}
    			
    		} else {
    			mav.addObject("result", name + " is not a csv file");
    		}
    	}
        
        return mav;
    }

	private void importUsers(File file) {
		List<User> users = new LinkedList<User>();
		Reader reader;
		try {
			reader = new FileReader(file);
			CSVReader<String[]> userReader = CSVReaderBuilder.newDefaultReader(reader);
			List<String[]> rUsers = userReader.readAll();
			
			for (String[] string : rUsers) {
				// TODO: improve this
				String[] userData = string[0].split(",");
				User user = new User();
				user.setName(userData[0]);
				user.setDateOfBirth(new Date(userData[2]));
				/*
				 *  TODO: in the real world we should add a method
				 *  to the Gender class that given a string identifies
				 *  the CONSTANT
				 */
				if (userData[1].trim().equals("Male")) {
					user.setGender(Gender.MALE);		
				} else {
					user.setGender(Gender.FEMALE);
				}
				
				users.add(user);
			}
			
			userRep.save(users);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	}
}
