package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.DbUtil;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fname = request.getParameter("first-name");
		String lname = request.getParameter("last-name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		if (!email.endsWith("@aurionpro.com")) {
			request.setAttribute("errorMessage",
					"Invalid email. Email address outside of the organization cannot be used.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("RegisterPage.jsp");
			dispatcher.forward(request, response);
			return;
		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		DbUtil dbUtil = DbUtil.getDbUtil();

		try {
			connection = dbUtil.connectToDb();
			String sql = "INSERT INTO admin (fname, lname, email, password) VALUES (?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, fname);
			preparedStatement.setString(2, lname);
			preparedStatement.setString(3, email);
			preparedStatement.setString(4, password);

			int rows = preparedStatement.executeUpdate();

			if (rows > 0) {

				request.setAttribute("successMessage", "Registration successful.");
			} else {

				request.setAttribute("errorMessage", "Registration failed. Please try again.");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again.");
		} finally {

			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher("RegisterSuccess.jsp");
			dispatcher.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
