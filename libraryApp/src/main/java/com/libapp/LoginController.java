package com.libapp;

import java.io.IOException;
import java.sql.SQLException;

import com.libapp.dao.DocumentDao;
import com.libapp.dao.LibrarianDao;
import com.libapp.dao.LoginAccessDao;
import com.libapp.dao.MemberDao;
import com.libapp.model.Document;
import com.libapp.model.Librarian;
import com.libapp.model.Member;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class Controller
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LoginController() {
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Search For Member and Librarian
		
		String search = request.getParameter("search").toString();
		String userType = request.getParameter("type").toString();
		
		if(userType.equals("Member")) {
			String mem = request.getParameter("userData");
			Member memData = new Member(mem);
			request.setAttribute("userData", memData);
		} else {
			String lib = request.getParameter("userData");
			Librarian libData = new Librarian(lib);
			request.setAttribute("userData", libData);
		}
		
		DocumentDao docDao = new DocumentDao();
		
		try {
			Document doc[] = docDao.getDocument(search);

			request.setAttribute("searchList", doc);
			request.setAttribute("type", userType);
			
			RequestDispatcher rd = request.getRequestDispatcher("searchList.jsp");
			rd.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Login for Member and Librarian
		
		int username = Integer.parseInt(request.getParameter("user"));
		String pwd = request.getParameter("pwd").toString();
		String userType = request.getParameter("type").toString();
		
		LoginAccessDao authData = new LoginAccessDao();
		String auth = authData.validateCredentials(username, pwd, userType);
		
		RequestDispatcher rd;
		
		if(!auth.equals("Incorrect username / User Type") && !auth.equals("Incorrect Password")) {
			if(userType.equals("Member")) {
				MemberDao memData = new MemberDao();
				Member mem = memData.getMemberData(Integer.parseInt(auth));
				request.setAttribute("userData", mem);
			} else {
				LibrarianDao libData = new LibrarianDao();
				Librarian lib = libData.getLibrarianData(Integer.parseInt(auth));
				request.setAttribute("userData", lib);
			}
			
			request.setAttribute("type", userType);

			rd = request.getRequestDispatcher("dashboard.jsp");
		} else {
			request.setAttribute("loginFail", auth);
			rd = request.getRequestDispatcher("index.jsp");
		}
		
		rd.forward(request, response);
	}

}
