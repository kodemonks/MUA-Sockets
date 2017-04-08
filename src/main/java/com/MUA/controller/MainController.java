package com.MUA.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.MUA.bean.EmailDataBean;
import com.MUA.mailProtocolImpl.POP3Session;
import com.MUA.mailProtocolImpl.SMTP;
import com.MUA.utilities.EmailParser;

/**
 * Main controller to handle requests from jsp pages
 *
 */

@RestController
@RequestMapping(value = "/")
public class MainController {

	// Class variables used
	POP3Session pop3;
	String mail;
	String pwd;
	SMTP mailSMTP;
	EmailDataBean dataBean = null;
	Integer count = 0;

	// Store info for all Emails
	ArrayList<EmailDataBean> totalEmailData = new ArrayList<EmailDataBean>();

	/**
	 * Login method MUA
	 * 
	 * @param mail
	 * @param password
	 * @return front.jsp/index.jsp
	 * 
	 *         Check username and password authenticate given SMTP server using
	 *         POP3 protocol
	 * 
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, @RequestParam("mail") String mail,
			@RequestParam("password") String password) {
		this.mail = mail;
		this.pwd = password;
		HttpSession session = null;

		pop3 = new POP3Session(mail, password);
		try {
			session = request.getSession();
			session.setAttribute("Email", mail);
			pop3.connectAndAuthenticate();
			mailSMTP = new SMTP(mail, password);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Unable to connect - " + e);
			return new ModelAndView("error.jsp");
		}
		System.out.println("Connected to POP3 server.");
		return new ModelAndView("/inbox");

	}

	/**
	 * Function to fetch Inbox messages and redirect to inbox.jsp page
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 * 
	 *             Fetch all inbox messages Stores each message data into
	 *             EmailDataBean
	 * 
	 */
	@RequestMapping(value = "inbox")
	public ModelAndView inbox(@RequestParam(value = "pageNum", required = false) String pageNum,ModelMap model)
			throws IOException {

				
		int step = 10;
		if (
			pageNum == null) {
			pageNum = "1";
			loadMailData();
		System.out.println("RELOADED AS NULL");
		}
		Integer page = Integer.parseInt(pageNum);

		System.out.println("PageNum:" + pageNum);
		// Extract inbox data from the SMTP server
		try {

			int start = (page - 1) * step;
			int end = (page - 1) * step + step;

			if (count < end) {
				end = count;
			}
			ArrayList<EmailDataBean> paginatedEmailData = new ArrayList<EmailDataBean>(
					totalEmailData.subList(start, end));
			System.out.println(count + "::" + start + "::" + end);
			model.addAttribute("emailData", paginatedEmailData);
			model.addAttribute("pagenum", page);
			model.addAttribute("count", count);
			return new ModelAndView("inbox.jsp");
		} catch (Exception e) {
			System.out.println("Exception while fetching inbox - " + e);
			return new ModelAndView("webError.jsp");

		}
	}

	// @RequestMapping(value = "inbox")
	// public ModelAndView inbox(ModelMap model) throws IOException {
	//
	// // Extract inbox data from the SMTP server
	// try {
	// int messageCount = pop3.getMessageCount();
	// loadMailData();
	// System.out.println("Message count" + messageCount);
	// model.addAttribute("emailData", totalEmailData);
	// return new ModelAndView("inbox.jsp");
	// } catch (Exception e) {
	// System.out.println("Exception while fetching inbox - " + e);
	// return new ModelAndView("webError.jsp");
	//
	// }
	// }

	/**
	 * Function to delete Mail using it's mail ID
	 * 
	 * Delete Email data using POP3
	 * 
	 * @param mailId
	 */
	@RequestMapping(value = "deleteMail", method = RequestMethod.DELETE)
	public void deleteMail(@RequestParam("mailId") String mailId) {
		try {
			System.out.println("WEWA AJA");
			pop3.deleteMessage(mailId);

		} catch (Exception e) {
			System.out.println("Cannot delete mail!");

		}

	}

	/**
	 * Function to read mails Here sends request to POP3 server with given
	 * mailID for logged in user and fetch complete body for email
	 * 
	 * @param map
	 * @param mailId
	 * @return
	 */
	@RequestMapping(value = "readMail", method = RequestMethod.GET)
	public ModelAndView readMail(ModelMap map, @RequestParam("id") String mailId) {

		try {
			for (EmailDataBean singleEmail : totalEmailData) {
				if (singleEmail.getMessageId().equals(mailId)) {
					map.addAttribute("mail", singleEmail.getTextMessage());
					map.addAttribute("from", singleEmail.getFrom());
					map.addAttribute("date", singleEmail.getDate());
					map.addAttribute("subject", singleEmail.getSubject());

				}

			}
		} catch (Exception e) {
			return new ModelAndView("webError.jsp");
		}
		return new ModelAndView("read.jsp");

	}

	@RequestMapping(value = "logout")
	public ModelAndView logout(HttpSession session) {
		session.removeAttribute("email");
		session.invalidate();
		try {
			pop3.close();
		} catch (Exception e) {
			// Ignore already closed
		}

		return new ModelAndView("homepage.jsp");
	}

	/**
	 * Function to send Email
	 * 
	 * @param to
	 * @param from
	 * @param subject
	 * @param message
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 * @throws InterruptedException
	 */
	@RequestMapping(value = "/sendStatus", method = RequestMethod.GET)
	public ModelAndView compose(@RequestParam("to") String to, @RequestParam("from") String from,
			@RequestParam("subj") String subject, @RequestParam("msg") String message, HttpServletResponse res)
			throws FileNotFoundException, IOException, InterruptedException {

		// System.out.println("Success in fetching these -" + to + " - " +
		// subject + " - " + message + " - " + from);

		if (mailSMTP != null) {
			if (mailSMTP.send(message, subject, to)) {
				return new ModelAndView("/inbox");
			} else {
				System.out.println("Connect to SMTP server failed!");
				return new ModelAndView("/inbox");
			}
		}

		return null;

	}

	/**
	 * Load Mail data first authenticate POP3 server then send commands to fetch
	 * Email list
	 * 
	 * @throws IOException
	 */
	public int loadMailData() throws IOException {
		totalEmailData.clear();
		// To execute the pending operations
		pop3.quit();

		// System.out.println("mail" + mail + "password:" + pwd);
		pop3 = new POP3Session(mail, pwd);

		try {
			pop3.connectAndAuthenticate();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Unable to connect");

		}
		EmailParser em = new EmailParser();

		System.out.println("Message count " + pop3.getMessageCount());
		String[] messages = pop3.getHeaders();
		String messageId = "", messageBody = "";
		int len = messages.length;
		count = len;
		int counter = 0;
		for (int i = len - 1; i >= 0; i--) {
			StringTokenizer messageTokens = new StringTokenizer(messages[i]);
			messageId = messageTokens.nextToken();
			messageBody = pop3.getMessage(messageId);
			EmailDataBean singleBean = em.parseMessage(messageBody, messageId);
			totalEmailData.add(singleBean);

			if(counter++>90)
			{
				count = counter;
				break;
			}
		}
		return count;
	}

}
