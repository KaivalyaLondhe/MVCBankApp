package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.exceptions.UserAlreadyExistsException;
import com.aurionpro.model.DbUtil;

@WebServlet("/AddCustomerController")
public class AddCustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddCustomerController() {
		super();

	}

	private boolean userExists(Connection conn, String email) throws SQLException {
		String query = "SELECT email FROM customer WHERE email = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, email);
			try (ResultSet rs = stmt.executeQuery()) {
				return rs.next();
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String firstName = request.getParameter("first-name");
		String lastName = request.getParameter("last-name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		DbUtil dbUtil = DbUtil.getDbUtil();

		try (Connection conn = dbUtil.connectToDb()) {
			if (userExists(conn, email)) {
				throw new UserAlreadyExistsException("A user with this email already exists.");
			}

			String sql = "INSERT INTO customer (fname, lname, email, password) VALUES (?, ?, ?, ?)";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, firstName);
				stmt.setString(2, lastName);
				stmt.setString(3, email);
				stmt.setString(4, password);
				stmt.executeUpdate();
			}

			request.setAttribute("successMessage", "Customer added successfully.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("AddNewCustomer.jsp");
			dispatcher.forward(request, response);

		} catch (UserAlreadyExistsException e) {
			request.setAttribute("errorMessage", e.getMessage());
			RequestDispatcher dispatcher = request.getRequestDispatcher("AddNewCustomer.jsp");
			dispatcher.forward(request, response);
		} catch (SQLException e) {
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
