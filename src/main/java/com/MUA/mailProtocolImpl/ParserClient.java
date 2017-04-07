

/**
 * 
 * 
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * IGNORE THIS CLASS TEST CLASS
 * 
 * 
 * 
 */







package com.MUA.mailProtocolImpl;



import java.util.StringTokenizer;

public class ParserClient {
	
	public static void main(String[] args)
	{
		String pattern = "Content-Length:(.*)"; 
//		POP3Session pop3 = new POP3Session("pop.gmail.com","saurabh.joshi25@gmail.com","getthere@DC11");
	//	POP3Session pop3 = new POP3Session("f21np@yahoo.com","coursework2017");
//		POP3Session pop3 = new POP3Session("pop-mail.outlook.com","networkapplication@outlook.com","coursework2017");
		POP3Session pop3 = new POP3Session("jj25@hw.ac.uk","P@s$w0rd");

		try {
			
			System.out.println("Connecting to POP3 server...");
			pop3.connectAndAuthenticate();
			System.out.println("Connected to POP3 server.");

			int messageCount = pop3.getMessageCount();
			System.out.println("\nWaiting massages on POP3 server : " + messageCount);
			
//			TestParser tp = new TestParser();
			String[] messages = pop3.getHeaders();
			for (int i=0; i<messages.length; i++) {
				StringTokenizer messageTokens = new StringTokenizer(messages[i]);
				String messageId = messageTokens.nextToken();
				String messageSize = messageTokens.nextToken();
				String messageBody = pop3.getMessage(messageId);
//				tp.parseMessage(messageBody);
//				System.out.println(
//					"\n-------------------- messsage " + messageId +
//					", size=" + messageSize + " --------------------");
//				System.out.print(messageBody);
//				System.out.println("-------------------- end of message " +
//					messageId + " --------------------");
//			}
				
//				System.out.println(messageBody);
			}
		}
		
		catch (Exception e){
			
		}
}
}
