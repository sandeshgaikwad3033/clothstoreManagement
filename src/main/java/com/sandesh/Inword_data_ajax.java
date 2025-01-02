package com.sandesh;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/Inword_data_ajax")
public class Inword_data_ajax extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/main";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (productId != null) {
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT product_code, product_name, base_price, seiling_price FROM inventory WHERE product_code=?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, productId);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String productCode = rs.getString("product_code");
                        String productName = rs.getString("product_name");
                        double basePrice = rs.getDouble("base_price");
                        double seilingPrice = rs.getDouble("seiling_price");

                        String jsonResponse = String.format(
                                "{\"product_code\":\"%s\", \"product_name\":\"%s\", \"base_price\":%.2f, \"seiling_price\":%.2f}",
                                productCode, productName, basePrice, seilingPrice);
                        out.print(jsonResponse);
                    } else {
                        out.print("{\"error\":\"No record found!\"}");
                    }
                }
            } catch (Exception e) {
                out.print("{\"error\":\"" + e.getMessage() + "\"}");
            }
        } else {
            out.print("{\"error\":\"No productId provided!\"}");
        }
    }

}
