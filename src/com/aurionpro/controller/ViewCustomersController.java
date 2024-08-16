package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.Customer;
import com.aurionpro.model.DbUtil;

@WebServlet("/ViewCustomersController")
public class ViewCustomersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ViewCustomersController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        List<Customer> customerList = new ArrayList<>();
        DbUtil dbUtil = DbUtil.getDbUtil();
        
        try (Connection conn = dbUtil.connectToDb()) {
            String sql = "SELECT customerid, fname, lname, email, accountnumber, balance FROM customer";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customerid"));
                    customer.setFname(rs.getString("fname"));
                    customer.setLname(rs.getString("lname"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAccountNumber(rs.getLong("accountnumber"));
                    customer.setBalance(rs.getDouble("balance"));
                    customerList.add(customer);
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Cannot retrieve customers", e);
        }

        // Set the customer list as a request attribute and forward to the JSP
        request.setAttribute("customerList", customerList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewCustomers.jsp");
        dispatcher.forward(request, response);
    }
		
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
