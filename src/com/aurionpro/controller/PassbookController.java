//package com.aurionpro.controller;
//
//import com.aurionpro.model.DbUtil;
//import com.aurionpro.model.Transaction;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet("/PassbookController")
//public class PassbookController extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("email") == null) {
//            response.sendRedirect("LoginPage.jsp");
//            return;
//        }
//
//        String email = (String) session.getAttribute("email");
//        List<Transaction> transactions = new ArrayList<>();
//
//        Connection connection = null;
//        DbUtil dbUtil = DbUtil.getDbUtil();
//
//        try {
//            connection = dbUtil.connectToDb();
//            String query = "SELECT * FROM transactions WHERE sender_account_number IN (SELECT accountnumber FROM customer WHERE email = ?) OR receiver_account_number IN (SELECT accountnumber FROM customer WHERE email = ?)";
//            try (PreparedStatement statement = connection.prepareStatement(query)) {
//                statement.setString(1, email);
//                statement.setString(2, email);
//                try (ResultSet resultSet = statement.executeQuery()) {
//                    while (resultSet.next()) {
//                        Transaction transaction = new Transaction();
//                        transaction.setTransactionId(resultSet.getInt("transaction_id"));
//                        transaction.setTransactionType(resultSet.getString("transaction_type"));
//                        transaction.setSenderAccountNumber(resultSet.getLong("sender_account_number"));
//                        transaction.setReceiverAccountNumber(resultSet.getLong("receiver_account_number"));
//                        transaction.setAmount(resultSet.getDouble("amount"));
//                        transaction.setTransactionDate(resultSet.getTimestamp("transaction_date"));
//                        transaction.setDescription(resultSet.getString("description"));
//                        transactions.add(transaction);
//                    }
//                }
//            }
//
//            request.setAttribute("transactions", transactions);
//            request.getRequestDispatcher("Passbook.jsp").forward(request, response);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Unable to fetch transactions.");
//            request.getRequestDispatcher("Passbook.jsp").forward(request, response);
//        } finally {
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//}


package com.aurionpro.controller;

import com.aurionpro.model.DbUtil;
import com.aurionpro.model.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PassbookController")
public class PassbookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        List<Transaction> transactions = new ArrayList<>();
        double balance = 0.0;

        Connection connection = null;
        DbUtil dbUtil = DbUtil.getDbUtil();

        try {
            connection = dbUtil.connectToDb();

            // Fetch balance
            String balanceQuery = "SELECT balance FROM customer WHERE email = ?";
            try (PreparedStatement balanceStatement = connection.prepareStatement(balanceQuery)) {
                balanceStatement.setString(1, email);
                try (ResultSet balanceResultSet = balanceStatement.executeQuery()) {
                    if (balanceResultSet.next()) {
                        balance = balanceResultSet.getDouble("balance");
                    }
                }
            }

            // Fetch transactions
            String transactionQuery = "SELECT * FROM transactions WHERE sender_account_number IN (SELECT accountnumber FROM customer WHERE email = ?) OR receiver_account_number IN (SELECT accountnumber FROM customer WHERE email = ?)";
            try (PreparedStatement transactionStatement = connection.prepareStatement(transactionQuery)) {
                transactionStatement.setString(1, email);
                transactionStatement.setString(2, email);
                try (ResultSet transactionResultSet = transactionStatement.executeQuery()) {
                    while (transactionResultSet.next()) {
                        Transaction transaction = new Transaction();
                        transaction.setTransactionId(transactionResultSet.getInt("transaction_id"));
                        transaction.setTransactionType(transactionResultSet.getString("transaction_type"));
                        transaction.setSenderAccountNumber(transactionResultSet.getLong("sender_account_number"));
                        transaction.setReceiverAccountNumber(transactionResultSet.getLong("receiver_account_number"));
                        transaction.setAmount(transactionResultSet.getDouble("amount"));
                        transaction.setTransactionDate(transactionResultSet.getTimestamp("transaction_date"));
                        transaction.setDescription(transactionResultSet.getString("description"));
                        transactions.add(transaction);
                    }
                }
            }

            request.setAttribute("transactions", transactions);
            request.setAttribute("balance", balance); // Set balance attribute
            request.getRequestDispatcher("Passbook.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch transactions or balance.");
            request.getRequestDispatcher("Passbook.jsp").forward(request, response);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}

