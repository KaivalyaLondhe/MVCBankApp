package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.DbUtil;

@WebServlet("/GenerateAccountNumberController")
public class GenerateAccountNumberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GenerateAccountNumberController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int customerId = Integer.parseInt(request.getParameter("customerId"));
		String message;
		DbUtil dbUtil = DbUtil.getDbUtil();
		try (Connection conn = dbUtil.connectToDb()) {

			String checkSql = "SELECT accountnumber FROM customer WHERE customerid = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
				checkStmt.setInt(1, customerId);
				try (ResultSet rs = checkStmt.executeQuery()) {
					if (rs.next() && rs.getLong("accountnumber") != 0) {

						message = "An account number is already assigned to this customer.";
						request.setAttribute("message", message);
						request.setAttribute("customerId", customerId);
						request.getRequestDispatcher("SelectCustomer.jsp").forward(request, response);
						return;
					}
				}
			}

			String newAccountNumber = generateRandomAccountNumber();
			String updateSql = "UPDATE customer SET accountnumber = ? WHERE customerid = ?";
			try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
				updateStmt.setLong(1, Long.parseLong(newAccountNumber));
				updateStmt.setInt(2, customerId);
				int rowsUpdated = updateStmt.executeUpdate();
				if (rowsUpdated > 0) {
					message = "Account number generated successfully: " + newAccountNumber;
				} else {
					message = "Failed to generate account number.";
				}
			}
		} catch (SQLException e) {
			throw new ServletException("Error updating account number", e);
		}

		request.setAttribute("message", message);
		request.setAttribute("customerId", customerId);
		request.getRequestDispatcher("SelectCustomer.jsp").forward(request, response);
	}

	private String generateRandomAccountNumber() {
		Random random = new Random();
		long accountNumber = 100000000000L + (long) (random.nextDouble() * 900000000000L);
		return String.valueOf(accountNumber);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
