package com.aurionpro.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtil {

	private Connection connection;
	private Statement statement;
	private static DbUtil dbUtil;
	private static final String URL = "jdbc:mysql://localhost:3306/bankingapp";
	private static final String USER = "root";
	private static final String PASSWORD = "root";
	private DbUtil() {
		
	}
	public static DbUtil getDbUtil() {
		if(dbUtil==null)
			dbUtil = new DbUtil();
		return dbUtil;
	}
	public Connection connectToDb() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankingapp" , "root", "root");
			System.out.println("Connection Successful");
			statement = connection.createStatement();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error connecting to database " + e);
		}
		return connection;
		
	}
	
	
	
	public ResultSet getUsersByRole(String role) {
	    ResultSet dbUsers = null;
	    String query = "select * from ";

	    // Determine the table based on the role
	    if ("admin".equalsIgnoreCase(role)) {
	        query += "admin";
	    } else if ("user".equalsIgnoreCase(role)) {
	        query += "custmer";
	    }

	    try {
	        dbUsers = statement.executeQuery(query);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return dbUsers;
	}

    public boolean validateCredentials(String email, String password, String role) {
        String query = "";
        if ("admin".equalsIgnoreCase(role)) {
            query = "SELECT * FROM admin WHERE email = ? AND password = ?";
        } else if ("customer".equalsIgnoreCase(role)) {
            query = "SELECT * FROM customer WHERE email = ? AND password = ?";
        } else {
            return false;
        }
        
        try (Connection conn = connectToDb();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
