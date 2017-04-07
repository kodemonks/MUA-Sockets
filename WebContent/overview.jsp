<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<%@ page errorPage="webError.jsp"%>

<html xml:lang="en-us" lang="en-us" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Overview</title>
<style type="text/css">
.body{background-color:red;}

</style>
</head>

<body>



	<h1>Overview</h1>
	<h2>Group members</h2>

	<ul>
		<li>Afnas</li>
		<li>Jithin</li>
		<li>Amar</li>
		<li>Jeff</li>
	</ul>

	<h2>Page List</h2>

	<ul>
		<li><a href="index.jsp">Login Page</a></li>
		<li><a href="compose.jsp">Compose Page</a></li>
		<li><a href="inbox.jsp">Inbox Page</a></li>
		<li><a href="homepage.jsp">Main User Page</a></li>
		<li><b>Read Message Page(On message click)</b></li>
	</ul>

	<h2>Page Overviews</h2>

	<h3>
		<a href="Login.jsp">Login Page</a>
	</h3>
	<p>Author: Jithin Janardanan</p>
	<p>In the login page we have added functions for validating the
		details provided</p>
	<ul>
		<li>A valtidation case to check whether the entered email id is
			in the correct format.</li>
		<li>A validation case to check whether the entered password is
			not less that eight charachters.</li>
		<li>A test case that which produces an error saying incorrect id,
			when the wrong format is entered.</li>
		<li>We have created the interace in user friendly manner.</li>
		<li>We have added multiple buttons for navigation such as Login
			that lets user sign in if above test cases are successfull and a
			validate button to check the page avnd css is validated</li>
	</ul>

	<h3>
		<a href="compose.jsp">Compose Page</a>
	</h3>
	<p>Author: Jithin Janardanan, Afnas Abdul Gafoor</p>

	<p>In the compose page we have added multiple functions for
		validating the details provided</p>
	<ul>
		<li>A valtidation case to check whether the entered to address is
			in the correct format.</li>
		<li>A valtidation case to check whether the entered from address
			is in the correct format.</li>
		<li>A test case that which produces an error saying incorrect id,
			when the wrong format is enetered.</li>
		<li>We can have added multiple buttons for navigation such as
			Send, Cancel, Inbox which takes user to his inbox page, Read, Logout
			which takes the user back to the main page, Page and CSS Validate for
			checking if the page and its css is valid</li>
	</ul>

	<h3>
		<a href="inbox.jsp">Inbox Page</a>
	</h3>
	<p>Author: Jithin Janardanan, Afnas Abdul Gafoor</p>
	<p>In the Inbox page we make changes to the mail box</p>
	<ul>
		<li>An option to read the emails.</li>
		<li>An option to delete the emails.</li>
		<li>We have added a check box option where we can opt to read and
			delete the required emails only.</li>
		<li>We have added multiple buttons for navigation such as
			Compose, Delete, Inbox, Read, Logout, Page and CSS Validate</li>
	</ul>

	<h3>
		Read Page
	</h3>
	<p>Author: Jeff Joshi, Amar Ayyampara</p>
	<p>This page allows to read your emails</p>
	<ul>
		<li>Displays the sender emails address</li>
		<li>Displays the subject of the email</li>
		<li>Displays the body of the email</li>
		<li>We have added multiple buttons for navigation such as
			Compose, Inbox, Read, Logout, Page and CSS Validate</li>
	</ul>

	<h3>
		<a href="front.jsp">Main User Page</a>
	</h3>
	<p>Author: Amar Ayyampara, Jeff Joshi</p>
	<p>This page allows to read your emails and contains</p>
	<ul>
		<li>posted by and contact information</li>
		<li>panels for adding the seating the buttons</li>
		<li>Dashboard for the mail client</li>
		<li>we have added multiple tabs for navigation such as Compose,
			Inbox, Read, Logout where user gets redirected back to the login
			page, About, Page and CSS Validate</li>
	</ul>

<!-- 	<h3>
		<a href="settings.jsp">Settings Page</a>
	</h3>
	<p>Author: Jithin Janardanan, Amar Ayyampara</p>
	<p>This page allows basic account management</p>
	<ul>
		<li>Provision for creating new password for an account</li>
		<li>panels for adding the seating the buttons</li>
		<li>Server and port settings provisions are provided</li>
		<li>we have added buttons to validate the page and css</li>
	</ul>
 -->
	<h3>
		<a href="overview.jsp">Overwiew Page</a>
	</h3>
	<p>Author: Jeff Joshi, Afnas Abdul Gafoor</p>
	<p>This page gives a basic overview of all the pages</p>

	<h2>References</h2>
	<ul>
		<li>Login https://www.w3schools.com/</li>
		<li>Inbox http://www.quackit.com/html/examples/</li>
		<li>About us
			https://www.w3.org/Style/Examples/011/firstcss.en.html</li>
	</ul>

</body>
</html>