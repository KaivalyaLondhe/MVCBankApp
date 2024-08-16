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

import com.aurionpro.model.DbUtil;
import com.aurionpro.model.Transaction;


@WebServlet("/ViewTransactionsController")
public class ViewTransactionsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ViewTransactionsController() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  List<Transaction> transactionList = new ArrayList<>();
	        DbUtil dbUtil = DbUtil.getDbUtil();
	        
	        try (Connection conn = dbUtil.connectToDb()) {
	            String sql = "SELECT transaction_id, sender_account_number, receiver_account_number, transaction_type, amount, transaction_date, description FROM transactions";
	            try (PreparedStatement stmt = conn.prepareStatement(sql);
	                 ResultSet rs = stmt.executeQuery()) {

	                while (rs.next()) {
	                    Transaction transaction = new Transaction();
	                    transaction.setTransactionId(rs.getInt("transaction_id"));
	                    transaction.setSenderAccountNumber(rs.getLong("sender_account_number"));
	                    transaction.setReceiverAccountNumber(rs.getLong("receiver_account_number"));
	                    transaction.setTransactionType(rs.getString("transaction_type"));
	                    transaction.setAmount(rs.getDouble("amount"));
	                    transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
	                    transaction.setDescription(rs.getString("description"));
	                    transactionList.add(transaction);
	                }
	            }

	        } catch (SQLException e) {
	            throw new ServletException("Cannot retrieve transactions", e);
	        }

	     
	        request.setAttribute("transactionList", transactionList);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewTransactions.jsp");
	        dispatcher.forward(request, response);
	    }

	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
