<!-- Update Document Information -->

<%@ page import="com.libapp.model.Member"%>
<%@ page import="com.libapp.model.Librarian"%>
<%@ page import="com.libapp.model.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Modify Document</title>
</head>
<body style="background-color: #c5d9ed;">

<!-- Session Meta Data for Member/Librarian -->
	<% 
		String userType = (String) request.getAttribute("type");
		Member memData = new Member();
		Librarian libData = new Librarian();
		if(userType.equals("Member")) {
			memData = (Member)request.getAttribute("userData");
		} else {
			libData = (Librarian)request.getAttribute("userData");
		}
	%>
	
<!-- Logout and Home -->
	<form id="home" action="home" method="post">
		<% if(userType.equals("Member")) { %>
	    		<input type="hidden" value="<%=memData%>" name="userData" />
	    <%	} else { %>
	    		<input type="hidden" value="<%=libData%>" name="userData" />
	    <%	} %>
		<input type="hidden" value="<%=userType%>" name="type" />
		<a href="javascript:{}" onclick="document.getElementById('home').submit();">Dashboard</a>
	</form>
	
	<form id="logout" action="logout" method="get">
		<a href="javascript:{}" onclick="document.getElementById('logout').submit();">Log out</a>
	</form>
	
	<%
		Document docData = (Document) request.getAttribute("docData");
	%>
	
	<br/>
	<br/>
	
<!-- Form for modifying document information -->
	<form action="searchFunctions" method="get">
		<input type="hidden" value="<%=userType%>" name="type" />
		<input type="hidden" value="<%=docData%>" name="borrowedDoc" />
		<input type="hidden" value="<%=libData%>" name="userData" />
	
		<label style="padding-right: 100px;" for="title"><b>Title</b></label>
	    <input type="text" value="<%=docData.getTitle()%>" name="title" required />
	    <br/>
	    <br/>
	    <label style="padding-right: 82px;" for="author"><b>Author</b></label>
	    <input type="text" value="<%=docData.getAuthor()%>" name="author" required />
	    <br/>
	    <br/>
	    <label style="padding-right: 90px;" for="genre"><b>Genre</b></label>
	    <input type="text" value="<%=docData.getGenre()%>" name="genre" required />
		<br/>
	    <br/>
	    <label style="padding-right: 65px;" for="publisher"><b>Publisher</b></label>
	    <input type="text" value="<%=docData.getPublisher()%>" name="publisher" required />
	    <br/>
	    <br/>
	    <label style="padding-right: 45px;" for="year"><b>Publish Year</b></label>
	    <input type="text" pattern="[0-9]{4}" value="<%=docData.getPublishYear()%>" name="year" required />
		<br/>
	    <br/>
	    <label style="padding-right: 81px;" for="edition"><b>Edition</b></label>
	    <input type="text" pattern="[0-9]+" value="<%=docData.getEdition()%>" name="edition" required />
	    <br/>
	    <br/>
	    <label style="padding-right: 36px;" for="issueno"><b>Issue Number</b></label>
	    <input type="text" pattern="[0-9]+" value="<%=docData.getIssueNo()%>" name="issueno" />
		<br/>
	    <br/>
	    <label style="padding-right: 60px;" for="issuedate"><b>Issue Date</b></label>
	    <input type="date" value="<%=docData.getIssueDate()%>" name="issuedate" />
	    <br/>
	    <br/>
	    <label style="padding-right: 86px;" for="editor"><b>Editor</b></label>
	    <input type="text" value="<%=docData.getEditor()%>" name="editor" />
		<br/>
	    <br/>
	    <label style="padding-right: 16px;" for="docname"><b>Document Name</b></label>
	    <input type="text" value="<%=docData.getDocName()%>" name="docname" />
	    <br/>
	    <br/>
	    <label style="padding-right: 22px;" for="doctype"><b>Document Type</b></label>
	    <select name="doctype" required>
	    	<option value="Book">Book</option>
		 	<option value="Journal Article">Journal Article</option>
		 	<option value="Magazine">Magazine</option>
		 	<option value="Thesis">Thesis</option>
		 	<option value="Technical Report">Technical Report</option>
		</select>
		<br/>
	    <br/>
		<button type="submit" name="button" value="updateinfo">Update</button>
	</form>
	
</body>
</html>