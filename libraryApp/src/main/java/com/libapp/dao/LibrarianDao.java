// Data Access Object for librarians table

package com.libapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.libapp.model.Librarian;

public class LibrarianDao {
	final String url = "jdbc:postgresql://localhost:5432/library";
	final String user = "postgres";
	final String password = "root";

	// Get Librarian Data
	
	public Librarian getLibrarianData(Integer lid) {
		String libData = "select * from librarians where lid = ?";
        
        Librarian lib = new Librarian();

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try (Connection conn = DriverManager.getConnection(url, user, password);
	 		    PreparedStatement libStmt = conn.prepareStatement(libData)){
	 			
			libStmt.setInt(1, lid);
	 		
            ResultSet libRes = libStmt.executeQuery();
            
            while (libRes.next()) {
            	lib.setLid(libRes.getInt("lid"));
            	lib.setLastname(libRes.getString("lastname"));
            	lib.setFirstname(libRes.getString("firstname"));
            	lib.setAddress(libRes.getString("address"));
            	lib.setContact(libRes.getInt("contact"));
            	lib.setDob(libRes.getDate("dob"));
            	lib.setEmail(libRes.getString("email"));
            	lib.setDoj(libRes.getDate("doj"));
            }
       }catch (SQLException e) {
    		 e.printStackTrace();;
       }
		
		return lib;
	}
}
