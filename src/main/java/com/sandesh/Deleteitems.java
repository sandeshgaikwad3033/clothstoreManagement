package com.sandesh;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Deleteitems
 */
@WebServlet("/Deleteitems")
public class Deleteitems extends HttpServlet {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/main";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String name = request.getParameter("name");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String query = "DELETE FROM inventory WHERE product_code = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                session.setAttribute("message", "Item is deleted in database.");
            } else {
                session.setAttribute("message", "No item found with that ID.");
            }

            response.sendRedirect("items/deleteitems.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error occurred: " + e.getMessage());
            response.sendRedirect("http://localhost/project/main/items/deleteitem.jsp");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
