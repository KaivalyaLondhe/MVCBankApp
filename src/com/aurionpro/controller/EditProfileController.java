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

@WebServlet("/EditProfileController")
public class EditProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("EditProfile.jsp?error=User not logged in.");
            return;
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            response.sendRedirect("EditProfile.jsp?error=User email not found.");
            return;
        }

        Connection connection = null;
        DbUtil dbUtil = DbUtil.getDbUtil();

        try {
            connection = dbUtil.connectToDb();
            String query = "SELECT fname, lname, email FROM customer WHERE email = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, email);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        request.setAttribute("firstName", resultSet.getString("fname"));
                        request.setAttribute("lastName", resultSet.getString("lname"));
                        request.setAttribute("email", resultSet.getString("email"));
                        request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("EditProfile.jsp?error=User not found.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("EditProfile.jsp?error=Database error: " + e.getMessage());
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("EditProfile.jsp?error=User not logged in.");
            return;
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            response.sendRedirect("EditProfile.jsp?error=User email not found.");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");

        Connection connection = null;
        DbUtil dbUtil = DbUtil.getDbUtil();

        try {
            connection = dbUtil.connectToDb();
            String query = "UPDATE customer SET fname = ?, lname = ?, password = ? WHERE email = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, firstName);
                statement.setString(2, lastName);
                statement.setString(3, password);
                statement.setString(4, email);
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("success", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile.");
                }
                request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("EditProfile.jsp?error=Database error: " + e.getMessage());
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
}
