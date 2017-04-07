<%@ page errorPage="webError.jsp"%>
<%@page import="com.MUA.bean.EmailDataBean"%>

<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Inbox</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	function deleteRow(inbox) {

		var table = document.getElementById(inbox).tBodies[0];
		var rowCount = table.rows.length;
		// var i=1 to start after header
		for (var i = 0; i < rowCount; i++) {
			var row = table.rows[i];
			// index of td contain checkbox is 8
			var id = row.cells[0].innerHTML
			var chkbox = row.cells[1].getElementsByTagName('input')[0];
			if (null != chkbox.type && true == chkbox.checked) {

				var ajaxUrl = "deleteMail?mailId=" + id;
				/* alert(ajaxUrl); */
				$.ajax({
					url : ajaxUrl,
					type : 'DELETE',
					success : function(result) {
						console.log("Message deleted!")
					}
				});

				table.deleteRow(i);
				rowCount--;
				i--;
				
			}
		}
		window.location = "/webapp-api/inbox";
	}
</script>
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

.navbtn {
	background: none;
	border: none;
	margin: 0;
	padding: 0;
}

.mailList {
	color: black;
	font-family: sans-serif;
	font-size: 15px;
	top: 0;
	margin-top: 0%;
	margin-left: 220px;
	/* 	border-style: solid; */
	/* 	border-color: #336699; */
	/* 	border-width: 1px; */
	padding-left: 3px;
	padding-bottom: 10px;
	height: 500px;
	width: 700px;
	display: inline-block;
	max-width: 700px;
	padding: 10px;
	word-break: break-all;
}

.delBTN {
	top: 0;
	margin-top: 0%;
	margin-left: 220px;
}
</style>



<style>
table {
	border-collapse: collapse;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

tr:hover {
	background-color: #f5f5f5
}
</style>

</head>

<body>


	<%
		if (request.getSession(false).getAttribute("Email") == null) {
			System.out.println("Found null sesison");
	%><jsp:forward page="index.jsp" />
	<%
		}
	%>





	<div class="nav">
		<button class="button button1" onclick="location.href='compose.jsp'">Compose</button>
		<button class="button button2"
			onclick="location.href='/webapp-api/inbox'">Inbox</button>
		<button class="button button5"
			onclick="location.href='/webapp-api/logout'">Logout <span style="font-size: 50%; color: white;">(<%= request.getSession().getAttribute("Email")%>)</span></button>
	</div>
	<div class="delBTN">
		<button type="button" onclick="deleteRow('inbox')">
			<img
				src="https://docs.qgis.org/testing/en/_images/mActionDeleteSelected.png"
				height="25" width="25" alt="" />
		</button>
	</div>





	<div class="mailList">

		<%
			Integer pageNum = (Integer) request.getAttribute("pagenum");
			Integer count = (Integer) request.getAttribute("count");

			if (pageNum - 1 > 0)
				out.write("<a href='/webapp-api/inbox?pageNum=" + (pageNum - 1)
						+ "'><img src='https://image.freepik.com/free-icon/arrow-previous-ios-7-interface-symbol_318-35423.jpg' width='15px' height='25px' style='padding-left:0px'></img></a>");

			if ((pageNum) * 10 < count)
				out.write("<a href='/webapp-api/inbox?pageNum=" + (pageNum + 1)
						+ "'><img src='http://img.freepik.com/free-icon/next_318-143043.jpg?size=338c&ext=jpg' width='15px' height='25px' style='padding-left:50px'></img></a>");
		%>

		<table id="inbox">
			<%
				ArrayList<EmailDataBean> totalEmailData = (ArrayList<EmailDataBean>) request.getAttribute("emailData");
				for (EmailDataBean singleEmailBean : totalEmailData) {
			%>
			<tr>
				<td style='display: none'><%=singleEmailBean.getMessageId()%></td>
				<td><input type='checkbox' /></td>
				<td style="width: 50%"><a
					href='readMail?id=<%=singleEmailBean.getMessageId()%>'> <%=singleEmailBean.getSubject()%></a></td>
				<td style="width: 40%; color: black"><%=singleEmailBean.getDate()%></td>
			</tr>

			<%
				}
			%>

		</table>
	</div>

</body>
</html>