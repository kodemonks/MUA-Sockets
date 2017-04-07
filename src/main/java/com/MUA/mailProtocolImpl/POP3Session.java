package com.MUA.mailProtocolImpl;
/**
 * POP3Session - Class for checking e-mail via POP3 protocol.
 *
 * (c) 2002 by Svetlin Nakov
 * Based on sources from INTERNET by Mark Wutka
 */

import java.io.*;
import java.net.*;
import java.util.*;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

/**
 * Implementation of POP3 protocol using Java Sockets
 * 
 * 
 */
public class POP3Session extends Object {
	/** socket read timeout */
	public static final int SOCKET_READ_TIMEOUT = 800 * 1000;

	protected Socket pop3Socket;
	protected BufferedReader in;
	protected PrintWriter out;

	private int port;
	private String userName;
	private String password;
	private String host;

	/**
	 * Return SMTP server from mailId
	 */
	public String getHostFromMail(String userName) {
		String host = "localhost";

		if (userName.contains("gmail.com")) {
			host = "smtp.gmail.com";
		}

		else if (userName.contains("yahoo.com")) {
			host = "pop.mail.yahoo.com";
		}

		else if (userName.contains("outlook.com")) {
			host = "pop-mail.outlook.com";
		}
		else if (userName.contains("hw.ac.uk")) {
			host = "outlook.office365.com";
		}
		

		System.out.println("HOST " + host);
		return host;
	}

	/**
	 * Creates new POP3 session by given POP3 host, username and password.
	 * Assumes POP3 port is 110 (default for POP3 service).
	 */
	public POP3Session(String userName, String password) {
		this(995, userName, password);
	}

	/**
	 * Creates new POP3 session by given POP3 host and port, username and
	 * password.
	 */
	public POP3Session(int port, String userName, String password) {
		this.host = getHostFromMail(userName);
		this.port = port;
		this.userName = userName;
		this.password = password;
	}

	/**
	 * Throws exception if given server response if negative. According to POP3
	 * protocol, positive responses start with a '+' and negative start with
	 * '-'.
	 */
	protected void checkForError(String response) throws IOException {
		if (response.charAt(0) != '+')
			throw new IOException(response);
		
		
	}

	/**
	 * @return the current number of messages using the POP3 STAT command.
	 */
	public int getMessageCount() throws IOException {
		// Send STAT command
		String response = doCommand("STAT");

		// The format of the response is +OK msg_count size_in_bytes
		// We take the substring from offset 4 (the start of the msg_count) and
		// go up to the first space, then convert that string to a number.
		try {
			String countStr = response.substring(4, response.indexOf(' ', 4));
			int count = (new Integer(countStr)).intValue();
			return count;
		} catch (Exception e) {
			throw new IOException("Invalid response - " + response);
		}
	}

	/**
	 * Get headers returns a list of message numbers along with some sizing
	 * information, and possibly other information depending on the server.
	 */
	public String[] getHeaders() throws IOException {
		doCommand("LIST");
		return getMultilineResponse();
	}

	/**
	 * Gets header returns the message number and message size for a particular
	 * message number. It may also contain other information.
	 */
	public String getHeader(String messageId) throws IOException {
		String response = doCommand("LIST " + messageId);
		return response;
	}

	/**
	 * Retrieves the entire text of a message using the POP3 RETR command.
	 */
	public String getMessage(String messageId) throws IOException {
		doCommand("RETR " + messageId);
		String[] messageLines = getMultilineResponse();
		StringBuffer message = new StringBuffer();
		for (int i = 0; i < messageLines.length; i++) {
			message.append(messageLines[i]);
			message.append("\n");
		}
		return new String(message);
	}

	/**
	 * Retrieves the first <linecount> lines of a message using the POP3 TOP
	 * command. Note: this command may not be available on all servers. If it
	 * isn't available, you'll get an exception.
	 */
	public String[] getMessageHead(String messageId, int lineCount) throws IOException {
		doCommand("TOP " + messageId + " " + lineCount);
		return getMultilineResponse();
	}

	/**
	 * Deletes a particular message with DELE command.
	 */
	public void deleteMessage(String messageId) throws IOException {
		System.out.println(doCommand("DELE " + messageId));
	}

	/**
	 * Undoes any pending deletions with RSET command.
	 */
	public void reset() throws IOException {
		doCommand("RSET");
	}

	/**
	 * Initiates a graceful exit by sending QUIT command.
	 */
	public void quit() throws IOException {
		doCommand("QUIT");
	}

	/**
	 * Connects to the POP3 server and logs on it with the USER and PASS
	 * commands.
	 */
	public void connectAndAuthenticate() throws IOException {
		// Make the connection
		// pop3Socket = new Socket(host, port);
		// pop3Socket.setSoTimeout(SOCKET_READ_TIMEOUT);

		SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
		SSLSocket pop3Socket = (SSLSocket) sslsocketfactory.createSocket(host, port);
		pop3Socket.setSoTimeout(SOCKET_READ_TIMEOUT);
		System.out.println("Connect & Authenticate | Timeout value  - " + SOCKET_READ_TIMEOUT);

		in = new BufferedReader(new InputStreamReader(pop3Socket.getInputStream()));
		out = new PrintWriter(new OutputStreamWriter(pop3Socket.getOutputStream()));

		// Receive the welcome message
		String response = in.readLine();
		checkForError(response);
		System.out.println("Sending creadentialss");
		// Send a USER command to authenticate
		doCommand("USER " + userName);

		// Send a PASS command to finish authentication
		doCommand("PASS " + password);
	}

	/**
	 * Closes down the connection to POP3 server (if open). Should be called if
	 * an exception is raised during the POP3 session.
	 * 
	 * @throws IOException
	 */
	public void close() throws IOException {
		try {
			in.close();
			out.close();
			pop3Socket.close();
		} catch (Exception ex) {
			// Ignore the exception. Probably the socket is not open.
		} finally {
			// Reconnect
			// System.out.println("Reconnecting to SMTP socket");
			// connectAndAuthenticate();

		}
	}

	/**
	 * Sends a POP3 command and retrieves the response. If the response is
	 * negative (begins with '-'), throws an IOException with received response.
	 */
	protected String doCommand(String command) throws IOException {
		out.println(command);
		out.flush();
		String response = in.readLine();
		checkForError(response);
		return response;
	}

	/**
	 * Retrieves a multi-line POP3 response. If a line contains "." by itself,
	 * it is the end of the response. If a line starts with a ".", it should
	 * really have two "."'s. We strip off the leading ".". If a line does not
	 * start with ".", there should be at least one line more.
	 */
	protected String[] getMultilineResponse() throws IOException {
		ArrayList lines = new ArrayList();

		while (true) {
			String line = in.readLine();

			if (line == null) {
				// Server closed connection
				throw new IOException("Server unawares closed the connection.");
			}

			if (line.equals(".")) {
				// No more lines in the server response
				break;
			}

			if ((line.length() > 0) && (line.charAt(0) == '.')) {
				// The line starts with a "." - strip it off.
				line = line.substring(1);
			}

			// Add read line to the list of lines
			lines.add(line);
		}

		String response[] = new String[lines.size()];
		lines.toArray(response);
		return response;
	}

}
