// Data Access Object for loginAccess, memLogin, libLogin tables

package com.libapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginAccessDao {
	final String url = "jdbc:postgresql://localhost:5432/library";
	final String user = "postgres";
	final String password = "root";

	// Validate Login Credentials
	
	public String validateCredentials(int username, String pwd, String userType) {
		String accCheck;
        if(userType.equals("Member")) {
        	accCheck = "SELECT * FROM memLogin WHERE aid = ?";
        } else {
        	accCheck = "SELECT * FROM libLogin WHERE aid = ?";
        }

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try (Connection conn = DriverManager.getConnection(url, user, password);
	 		    PreparedStatement accStmt = conn.prepareStatement(accCheck)){
	 			
			accStmt.setInt(1, username);
	 		
            ResultSet accExists = accStmt.executeQuery();
            
            //If account exists
            
            if (accExists.next()) {
            	String pwdCheck = "select * from loginAccess where aid = ? and pwd = ?";
            	PreparedStatement pwdStmt = conn.prepareStatement(pwdCheck);
            	pwdStmt.setInt(1, username);
            	pwdStmt.setString(2, pwd);
            	ResultSet pwdExists = pwdStmt.executeQuery();
            	
            	if(pwdExists.next()) {
            		Integer userId;
            		if(userType.equals("Member")) {
                		userId = accExists.getInt("mid");
                	} else {
                		userId = accExists.getInt("lid");
                	}
            		
            		return userId.toString();
            	}
            } else {
            	return "Incorrect username / User Type";
            }
       }catch (SQLException e) {
    		 e.printStackTrace();
       }
		
		return "Incorrect Password";
	}
}
