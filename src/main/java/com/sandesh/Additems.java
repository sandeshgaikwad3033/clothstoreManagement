package com.sandesh;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Additems
 */
@WebServlet("/Additems")
public class Additems extends HttpServlet {

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Start session
	        HttpSession session = request.getSession();

	        // Get parameters from the request
	        String id = request.getParameter("id");
	        String name = request.getParameter("name");
	        String basePrice = request.getParameter("baseprice");
	        String ceilingPrice = request.getParameter("ceilingprice");
	        String quantity = request.getParameter("quantity");
	        String pdate = request.getParameter("pdate");
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            // Establish connection
	            conn = DatabaseMethods.conction();

	            // Check if product ID already exists
	            String selectSQL = "SELECT * FROM inventory WHERE product_code = ?";
	            pstmt = conn.prepareStatement(selectSQL);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                session.setAttribute("status", "Product ID is taken.");
	                response.sendRedirect("items/getitem.jsp");
	                return;
	            }

	            // Insert new item into the database
	            String insertSQL = "INSERT INTO inventory (product_code, product_name, base_price, seiling_price, quantity, product_date) VALUES (?, ?, ?, ?, ?, ?)";
	            pstmt = conn.prepareStatement(insertSQL);
	            pstmt.setString(1, id);
	            pstmt.setString(2, name);
	            pstmt.setString(3, basePrice);
	            pstmt.setString(4, ceilingPrice);
	            pstmt.setString(5, quantity);
	            pstmt.setString(6, pdate);
	            int rowsAffected = pstmt.executeUpdate();

	            if (rowsAffected > 0) {
	                session.setAttribute("message", "Item saved in database.");
	                response.sendRedirect("items/getitem.jsp");
	            } else {
	                response.getWriter().println("Data not saved in database.");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.getWriter().println("Database error: " + e.getMessage());
	        } finally {
	            // Clean up resources
	            try {
	                if (rs != null) rs.close();
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	    }

}
