package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.DbUtil;

@WebServlet("/TransactionController")
public class TransactionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String transactionType = request.getParameter("transactionType");
		String receiverAccountNumber = request.getParameter("receiverAccountNumber");
		String amountStr = request.getParameter("amount");
		String description = request.getParameter("description");

		double amount;
		try {
			amount = Double.parseDouble(amountStr);
			if (amount <= 0) {
				throw new IllegalArgumentException("Transaction amount must be a positive value.");
			}
		} catch (IllegalArgumentException e) {
			request.setAttribute("error", e.getMessage());
			request.getRequestDispatcher("Transactionpage.jsp").forward(request, response);
			return;
		}

		Connection connection = null;
		DbUtil dbUtil = DbUtil.getDbUtil();

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("email") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String email = (String) session.getAttribute("email");
		String senderAccountNumber = null;

		try {
			connection = dbUtil.connectToDb();
			connection.setAutoCommit(false);

			String query = "SELECT accountnumber FROM customer WHERE email = ?";
			try (PreparedStatement statement = connection.prepareStatement(query)) {
				statement.setString(1, email);
				try (ResultSet resultSet = statement.executeQuery()) {
					if (resultSet.next()) {
						senderAccountNumber = resultSet.getString("accountnumber");
					} else {
						throw new SQLException("Account not found for email: " + email);
					}
				}
			}

			if ("credit".equalsIgnoreCase(transactionType) || "debit".equalsIgnoreCase(transactionType)) {
				receiverAccountNumber = senderAccountNumber;
			}

			if ("debit".equalsIgnoreCase(transactionType) || "money transfer".equalsIgnoreCase(transactionType)) {
				if (!hasSufficientBalance(connection, senderAccountNumber, amount)) {
					request.setAttribute("error", "Insufficient balance for this transaction.");
					request.getRequestDispatcher("Transactionpage.jsp").forward(request, response);
					return;
				}
			}

			if ("credit".equalsIgnoreCase(transactionType)) {
				updateBalance(connection, senderAccountNumber, amount, true);
			} else if ("debit".equalsIgnoreCase(transactionType)) {
				updateBalance(connection, senderAccountNumber, amount, false);
			} else if ("money transfer".equalsIgnoreCase(transactionType)) {
				updateBalance(connection, senderAccountNumber, amount, false);
				updateBalance(connection, receiverAccountNumber, amount, true);
			}

			query = "INSERT INTO transactions (sender_account_number, receiver_account_number, transaction_type, transaction_date, amount, description) VALUES (?, ?, ?, NOW(), ?, ?)";
			try (PreparedStatement statement = connection.prepareStatement(query)) {
				statement.setString(1, senderAccountNumber);
				statement.setString(2, receiverAccountNumber);
				statement.setString(3, transactionType);
				statement.setDouble(4, amount);
				statement.setString(5, description);
				statement.executeUpdate();
			}

			connection.commit();
			request.setAttribute("success", "Transaction successful.");
			request.getRequestDispatcher("Transactionpage.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			if (connection != null) {
				try {
					connection.rollback();
				} catch (SQLException rollbackException) {
					rollbackException.printStackTrace();
				}
			}
			request.setAttribute("error", "Transaction failed due to a database error.");
			request.getRequestDispatcher("Transactionpage.jsp").forward(request, response);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	private void updateBalance(Connection connection, String accountNumber, double amount, boolean isCredit)
			throws SQLException {
		String query = "UPDATE customer SET balance = balance " + (isCredit ? "+" : "-") + " ? WHERE accountnumber = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setDouble(1, amount);
			statement.setString(2, accountNumber);
			statement.executeUpdate();
		}
	}

	private boolean hasSufficientBalance(Connection connection, String accountNumber, double amount)
			throws SQLException {
		String query = "SELECT balance FROM customer WHERE accountnumber = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, accountNumber);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					double currentBalance = resultSet.getDouble("balance");
					return currentBalance >= amount;
				} else {
					throw new SQLException("Account not found: " + accountNumber);
				}
			}
		}
	}
}
