<!-- Search Page -->

<%@ page import="com.libapp.model.Member"%>
<%@ page import="com.libapp.model.Librarian"%>
<%@ page import="com.libapp.model.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Results</title>
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
	<br/>
	<br/>

<!-- Search List -->
	<%
		Document searchList[] = (Document[]) request.getAttribute("searchList");
		for(int i = 0; i < searchList.length; i++) {
			String disabled = "enabled";
			String deletable = "disabled";
	%>
			<form action="searchFunctions" method="get">
		  		<input type="hidden" value="<%=userType%>" name="type" />
		  		<input type="hidden" value="<%=searchList[i]%>" name="borrowedDoc" />
	
	<%			out.println("ID: " + searchList[i].getDid() + " || " + 
							"Title: " + searchList[i].getTitle() + " || " +
							"Author: " + searchList[i].getAuthor() + " || " + 
							"Genre: " + searchList[i].getGenre() +  " || " + 
							"Publisher: " + searchList[i].getPublisher() +  " || " + 
							"Publish Year: " + searchList[i].getPublishYear() +  " || " + 
							"Edition: " + searchList[i].getEdition() +  " || " + 
							"Issue Number: " + searchList[i].getIssueNo() +  " || " + 
							"Issue Date: " + searchList[i].getIssueDate() +  " || " + 
							"Editor: " + searchList[i].getEditor() +  " || " + 
							"Magazine/Journal Name: " + searchList[i].getDocName() +  " || " + 
							"Document Type: " + searchList[i].getDocType() +  " || " + 
							"Total Copies: " + searchList[i].getTotal() +  " || " + 
							"Available Copies: " + searchList[i].getRemaining()
							);
				
				if(searchList[i].getRemaining() == 0) {
					disabled = "disabled";
				}
				if(searchList[i].getRemaining() == searchList[i].getTotal()) {
					deletable = "enabled";
				}
				if(userType.equals("Member")){
	%>
					<input type="hidden" value="<%=memData%>" name="userData" />
					<br/>
					<button type="submit" name="button" value="borrow" <%=disabled%>>Borrow</button>
	<%			} else {
	%>
					<input type="hidden" value="<%=libData%>" name="userData" />
					<br/>
					<button type="submit" name="button" value="addCopy">Add Copy</button>
					<button type="submit" name="button" value="delCopy" <%=disabled%>>Delete Copy</button>
					<button type="submit" name="button" value="modifyInfo">Modify Information</button>
					<button type="submit" name="button" value="delDoc" <%=deletable%>>Delete Document</button>
	<%
				}
	%>
			</form>
			<br/>
	<%	}
	%>
	
	<!-- Add a borrow button next to search results with both inside a form and then call for borrow -->
	<!-- Also grey out the borrow button if copies are over -->
	<!-- Show warning on borrow page if any books are overdue -->
	
</body>
</html>