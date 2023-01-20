<!-- Add a new Document -->

<%@ page import="com.libapp.model.Member"%>
<%@ page import="com.libapp.model.Librarian"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Document</title>
</head>
<body style="background-color: #c5d9ed;">

<!-- Session Meta Data for Member/Librarian -->
	<% 
		String userType = (String) request.getAttribute("type");
		Librarian libData = new Librarian();
		libData = (Librarian)request.getAttribute("userData");
	%>
	
<!-- Logout and Home -->
	<form id="home" action="home" method="post">
	    <input type="hidden" value="<%=libData%>" name="userData" />

		<input type="hidden" value="<%=userType%>" name="type" />
		<a href="javascript:{}" onclick="document.getElementById('home').submit();">Dashboard</a>
	</form>
	
	<form id="logout" action="logout" method="get">
		<a href="javascript:{}" onclick="document.getElementById('logout').submit();">Log out</a>
	</form>
	
	<br/>
	<br/>
	
<!-- Form to add a new Document -->
	<form action="addDocument" method="get">
		<input type="hidden" value="<%=userType%>" name="type" />
		<input type="hidden" value="<%=libData%>" name="userData" />

		<label for="title" style="padding-right: 100px;"><b>Title</b></label>
	    <input type="text" name="title" required />
	    <br/>
	    <br/>
	    <label for="author" style="padding-right: 82px;"><b>Author</b></label>
	    <input type="text" name="author" required />
	    <br/>
	    <br/>
	    <label for="genre" style="padding-right: 90px;"><b>Genre</b></label>
	    <input type="text" name="genre" required />
		<br/>
		<br/>
	    <label for="publisher" style="padding-right: 65px;"><b>Publisher</b></label>
	    <input type="text" name="publisher" required />
	    <br/>
	    <br/>
	    <label for="year" style="padding-right: 45px;"><b>Publish Year</b></label>
	    <input type="text" pattern="[0-9]{4}" name="year" required />
		<br/>
		<br/>
	    <label for="edition" style="padding-right: 80px;"><b>Edition</b></label>
	    <input type="text" pattern="[0-9]+" name="edition" required />
	    <br/>
	    <br/>
	    <label for="issueno" style="padding-right: 35px;"><b>Issue Number</b></label>
	    <input type="text" pattern="[0-9]+" name="issueno" />
		<br/>
		<br/>
	    <label for="issuedate" style="padding-right: 60px;"><b>Issue Date</b></label>
	    <input type="date" name="issuedate" />
	    <br/>
	    <br/>
	    <label for="editor" style="padding-right: 85px;"><b>Editor</b></label>
	    <input type="text" name="editor" />
		<br/>
		<br/>
	    <label for="docname" style="padding-right: 15px;"><b>Document Name</b></label>
	    <input type="text" name="docname" />
	    <br/>
	    <br/>
	    <label for="total" style="padding-right: 83px;"><b>Copies</b></label>
	    <input type="text" pattern="[0-9]+" name="total" required />
	    <br/>
	    <br/>
	    <label for="doctype" style="padding-right: 21px;"><b>Document Type</b></label>
	    <select name="doctype" required>
	    	<option value="Book">Book</option>
		 	<option value="Journal Article">Journal Article</option>
		 	<option value="Magazine">Magazine</option>
		 	<option value="Thesis">Thesis</option>
		 	<option value="Technical Report">Technical Report</option>
		</select>
		<br/>
		<br/>
		<button type="submit" name="button" value="add">Add</button>
	</form>
</body>
</html>