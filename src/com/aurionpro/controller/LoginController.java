package com.aurionpro.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.DbUtil;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		DbUtil dbUtil = DbUtil.getDbUtil();
		boolean isValidUser = dbUtil.validateCredentials(email, password, role);

		if (isValidUser) {
			HttpSession session = request.getSession();
			session.setAttribute("email", email);

			RequestDispatcher requestDispatcher;
			if ("admin".equalsIgnoreCase(role)) {
				requestDispatcher = request.getRequestDispatcher("AdminLandingPage.jsp");
			} else if ("customer".equalsIgnoreCase(role)) {

				requestDispatcher = request.getRequestDispatcher("CustomerLandingPage.jsp");
			} else {
				requestDispatcher = request.getRequestDispatcher("LoginFailed.jsp");
			}
			requestDispatcher.forward(request, response);
		} else {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("LoginFailed.jsp");
			requestDispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
