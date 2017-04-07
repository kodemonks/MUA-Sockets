<?xml version="1.0" encoding="UTF-8"?>
<%@ page errorPage="webError.jsp"%>

<%@page import="com.MUA.utilities.EmailParser"%>
<%@page import="java.util.*"%>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us" xml:lang="en-us">
<head>

<title>Read Message</title>
<style type='text/css'>
body {
	color: white;
	font-family: sans-serif;
	font-size: 25px;
}

.nav {
	background-color: #dd4b39;
	text-align: center;
	width: 200px;
	height: 100%;
	position: fixed;
	top: 0px;
	left: 0px;
}

.button {
	border: none;
	color: white;
	padding: 16px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s;
	transition-duration: 0.4s;
	cursor: pointer;
}

.button1 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}

.button2 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button2:hover {
	background-color: #008CBA;
	color: white;
}

.button3 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button3:hover {
	background-color: #FFC0CB;
	color: white;
}

.button4 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button4:hover {
	background-color: #FFA500;
	color: white;
}

.button5 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 22px;
	color: white;
	border: 2px solid #dd4b39;
}

.button5:hover {
	background-color: #555555;
	color: white;
}

.button6 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button6:hover {
	background-color: #c0c0c0;
	color: white;
}

.box {
	width: 200px;
	text-align: center;
	background: white;
	color: #dd4b39;
}

.messageContent {
	text-align: left;
	vertical-align: middle;
	width: auto;
	display: block;
	margin-left: 220px;
	margin-right: auto;
	color: black;
	font-family: sans-serif;
	font-size: 25px;
	top: 0;
	margin-top: 0%;
	margin-left: 220px;
}
</style>
</head>

<body>

	<%
	
  if (request.getSession(false).getAttribute("Email") == null)
  {
	System.out.println("Found null sesison");
    %><jsp:forward page="index.jsp" />
	<%
  
  }else
  {

	  System.out.println("Got session "+session);
	  System.out.println(session.getAttribute("Email"));
  }
%>

	<div class="nav">
		<button class="button button1" onclick="location.href='compose.jsp'">Compose</button>
		<button class="button button2" onclick="location.href='inbox'">Inbox</button>
	<button class="button button5"
			onclick="location.href='/webapp-api/logout'">Logout <span style="font-size: 50%; color: white;">(<%= request.getSession().getAttribute("Email")%>)</span></button>
	
	</div>
	<div class="messageContent">

		<p>
			<label id="from">From: <b>${from}</b></label>

		</p>

		<p>
			<label id="subject">Subject: <b>${subject}</b></label>
		</p>


		<hr />
		<br /> <br />

		<p style="font-size: 16px;">
			<br /> <label id="mail">${mail}</label>
		</p>
		<br /> <br /> <br />
		<hr />
		<p style="font-size: 16px;">
			<br /> <label id="date">Dated - <b>${date}</b></label>
		</p>


	</div>
</body>
</html>
