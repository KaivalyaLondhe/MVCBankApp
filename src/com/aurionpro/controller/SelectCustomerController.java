package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.Customer;
import com.aurionpro.model.DbUtil;

@WebServlet("/accountnumbergenerator")
public class SelectCustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SelectCustomerController() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String customerIdParam = request.getParameter("customerId");
		Customer customer = null;
		String message = null;
		DbUtil dbUtil = DbUtil.getDbUtil();

		if (customerIdParam != null && !customerIdParam.trim().isEmpty()) {
			int customerId = Integer.parseInt(customerIdParam);

			try (Connection conn = dbUtil.connectToDb()) {
				String sql = "SELECT fname, lname, email, balance FROM customer WHERE customerid = ?";
				try (PreparedStatement stmt = conn.prepareStatement(sql)) {
					stmt.setInt(1, customerId);
					try (ResultSet rs = stmt.executeQuery()) {
						if (rs.next()) {
							customer = new Customer();
							customer.setCustomerId(customerId);
							customer.setFname(rs.getString("fname"));
							customer.setLname(rs.getString("lname"));
							customer.setEmail(rs.getString("email"));
							customer.setBalance(rs.getDouble("balance"));
						}
					}
				}
			} catch (SQLException e) {
				throw new ServletException("Cannot retrieve customer details", e);
			}
		}

		List<Customer> customerList = new ArrayList<>();
		try (Connection conn = dbUtil.connectToDb()) {
			String sql = "SELECT customerid FROM customer WHERE accountnumber = 0";
			try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					Customer c = new Customer();
					c.setCustomerId(rs.getInt("customerid"));
					customerList.add(c);
				}
			}
		} catch (SQLException e) {
			throw new ServletException("Cannot retrieve customer list", e);
		}

		request.setAttribute("customerList", customerList);
		request.setAttribute("customer", customer);
		request.setAttribute("message", message);
		request.getRequestDispatcher("SelectCustomer.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
