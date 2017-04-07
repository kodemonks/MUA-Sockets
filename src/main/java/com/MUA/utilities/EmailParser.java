package com.MUA.utilities;

import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import org.apache.james.mime4j.message.BinaryBody;
import org.apache.james.mime4j.message.BodyPart;
import org.apache.james.mime4j.message.Entity;
import org.apache.james.mime4j.message.Message;
import org.apache.james.mime4j.message.Multipart;
import org.apache.james.mime4j.message.TextBody;
import org.apache.james.mime4j.parser.Field;
import org.apache.james.mime4j.parser.MimeEntityConfig;

import com.MUA.bean.EmailDataBean;

public class EmailParser {

	private StringBuffer txtBody;
	private StringBuffer htmlBody;
	ArrayList<String> headers = null;
	InputStream is = null;
	/**
	 *
	 * @param emailData
	 *            to parse
	 */

	MimeEntityConfig mcfg = new MimeEntityConfig();
	String to, from, subject, date;

	public EmailDataBean parseMessage(String emailData, String messageId) {

		String emailContent;
		EmailDataBean edb = new EmailDataBean();
		FileInputStream fis = null;
		headers = new ArrayList<String>();

		txtBody = new StringBuffer();
		htmlBody = new StringBuffer();

		try {
			is = new ByteArrayInputStream(emailData.getBytes());
			// Message mimeMsg = new Message(new FileInputStream();
			mcfg.setMaxContentLen(-1);
			mcfg.setMaxLineLen(-1);
			mcfg.setMaxLineLen(-1);
			mcfg.setStrictParsing(false);

			Message mimeMsg = new Message(is, mcfg);

			if (mimeMsg.getTo() != null)
				to = mimeMsg.getTo().toString();
			else
				to = "N/A";
			if (mimeMsg.getFrom() != null)
				from = mimeMsg.getFrom().toString();
			else
				from = "N/A";
			if (mimeMsg.getSubject() != null)
				subject = mimeMsg.getSubject();
			else
				subject = "N/A";
			if (mimeMsg.getDate() != null)
				date = mimeMsg.getDate().toString();
			else
				date = "N/A";
			// Get some standard headers
			headers.add(to);
			headers.add(from);
			headers.add(subject);
			headers.add(date);

			// If message contains many parts - parse all parts
			if (mimeMsg.isMultipart()) {
				Multipart multipart = (Multipart) mimeMsg.getBody();
				parseBodyParts(multipart);
			} else {
				// If it's single part message, just get text body
				String text = getTxtPart(mimeMsg);
				txtBody.append(text);
			}

			if (htmlBody.length() == 0)
				emailContent = txtBody.toString();
			else
				emailContent = htmlBody.toString();
			edb.setMessageId(messageId);
			edb.setTo(to);
			edb.setFrom(from);
			edb.setSubject(subject);
			edb.setDate(date);
			edb.setTextMessage(emailContent);

			return edb;
		} catch (Exception ex) {
			ex.fillInStackTrace();
			System.out.println(ex);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}
		}
		return edb;
	}

	/**
	 * This method classifies bodyPart as text, html or attached file
	 *
	 * @param multipart
	 * @throws IOException
	 */
	private void parseBodyParts(Multipart multipart) throws IOException {
		for (BodyPart part : multipart.getBodyParts()) {
			if (part.isMimeType("text/plain")) {
				String txt = getTxtPart(part);
				txtBody.append(txt);
			} else if (part.isMimeType("text/html")) {
				String html = getTxtPart(part);
				htmlBody.append(html);
			} // If current part contains other, parse it again by recursion
//			if (part.isMultipart()) {
//				parseBodyParts((Multipart) part.getBody());
//			}
		}
	}

	/**
	 *
	 * @param part
	 * @return
	 * @throws IOException
	 */
	private String getTxtPart(Entity part) throws IOException {
		// Get content from body
		TextBody tb = (TextBody) part.getBody();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		tb.writeTo(baos);
		return new String(baos.toByteArray());
	}

}