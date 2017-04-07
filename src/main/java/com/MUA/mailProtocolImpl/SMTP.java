package com.MUA.mailProtocolImpl;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

import org.apache.commons.codec.binary.Base64;

public class SMTP {

	String fromEmailAddress;
	String authString;
	InetAddress mailHost;
	InetAddress localhost;
	BufferedReader msgBR;
	PrintWriter out;
	int port;
	String host;
	/** socket read timeout */
	public static final int SOCKET_READ_TIMEOUT = 800 * 1000;

	public static void main(String... lol) throws IOException, InterruptedException {
		SMTP a = new SMTP("networkapplication@outlook.com", "coursework2017");
		a.send("asdasdasdasd", "test", "b.bhups@gmail.com");
	}

	public SMTP(String fromEmail, String password) throws IOException {
		String hostv = getHostFromMail(fromEmail);
		int port = 465;
		this.authString = fetchAuthString(fromEmail, password);
		this.host = hostv;
		this.port = port;
		this.fromEmailAddress = fromEmail;
	}

	/**
	 * Function to send Email to single Or multiple users Here we use Plain AUTH
	 * to authenticate and then start adding to emails + subject and message
	 * 
	 * @param message
	 * @param subject
	 * @param to
	 * @return
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public boolean send(String message, String subject, String to) throws IOException, InterruptedException {
		SSLSocket smtpPipe;
		InputStream inn;
		OutputStream outt;
		BufferedReader msg;

		InputStream is = new ByteArrayInputStream(message.getBytes());

		// read it with BufferedReader
		msg = new BufferedReader(new InputStreamReader(is));

		smtpPipe = (SSLSocket) ((SSLSocketFactory) SSLSocketFactory.getDefault())
				.createSocket(InetAddress.getByName(host), port);

		if (smtpPipe == null) {
			return false;
		}
		smtpPipe.setSoTimeout(SOCKET_READ_TIMEOUT);
		inn = smtpPipe.getInputStream();
		outt = smtpPipe.getOutputStream();
		msgBR = new BufferedReader(new InputStreamReader(inn));
		out = new PrintWriter(new OutputStreamWriter(outt), true);
		if (inn == null || outt == null) {
			System.out.println("Failed to open streams to socket.");
			return false;
		}
		out.println("HELO USER");
		out.println("AUTH PLAIN " + authString);
		out.println("MAIL FROM:<" + fromEmailAddress + ">");
		ArrayList<String> emailList = fetchMultipleSend(to);
		for (String email : emailList) {
			out.println("RCPT TO:<" + email + ">");
			String recipientOK = msgBR.readLine();
			System.out.println("Sent mail success " + recipientOK);

		}

		out.println("DATA");
		out.println("SUBJECT : " + subject);
		String line;
		while ((line = msg.readLine()) != null) {
			out.println(line);
		}
		out.print("\r\n");
		out.print(".");
		out.print("\r\n");
		out.flush();
		out.println("QUIT");

		return true;
	}

	/**
	 * Return SMTP server from mailId used as Yahoo or gmail
	 */
	public String getHostFromMail(String userName) {
		String host = "localhost";

		if (userName.contains("gmail.com")) {
			host = "smtp.gmail.com";
		}

		else if (userName.contains("yahoo.com")) {
			host = "smtp.mail.yahoo.com";
		}

		else if (userName.contains("aol.com")) {
			host = "smtp.aol.com";
		} else if (userName.contains("hotmail.com")) {
			host = "mail.hotmail.com";
		} else if (userName.contains("outlook.com")) {
			host = "smtp-mail.outlook.com";
		} else if (userName.contains("hw.ac.uk")) {
			host = "smtp.outlook365.com";
		}

		System.out.println("HOST" + host);
		return host;
	}

	/**
	 * Creating Auth string using Username and password Used Base64 encoder to
	 * encode string
	 * 
	 * @param uname
	 * @param password
	 * @return
	 * @throws IOException
	 */
	public static String fetchAuthString(String uname, String password) throws IOException {

		String testString = '\000' + uname + '\000' + password;

		byte[] bytesEncoded = Base64.encodeBase64(testString.getBytes());
		String a = new String(bytesEncoded);

		return a;

	}

	/**
	 * Method to fetch list of users to email from comma seaprated string
	 * 
	 * @param emailList
	 * @return
	 */
	public static ArrayList<String> fetchMultipleSend(String emailList) {
		StringTokenizer st = new StringTokenizer(emailList, ",");
		ArrayList<String> email = new ArrayList<String>();
		while (st.hasMoreTokens()) {
			email.add(st.nextToken());

		}

		return email;

	}

}