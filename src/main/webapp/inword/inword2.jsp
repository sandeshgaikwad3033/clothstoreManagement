<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt</title>
</head>
<body>

<%
    
    // Retrieve form data
    String id = request.getParameter("pid");
    String quantityStr = request.getParameter("q");
    String vendorName = request.getParameter("vid");
    String purchaseDate = request.getParameter("pdate");
    
    int quantity = Integer.parseInt(quantityStr);
    String productName = "";
    double basePrice = 0.0;
    int updatedQuantity = 0;

    // Database connection
    String url = "jdbc:mysql://localhost:3306/main";
    String user = "root";
    String password = "";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Get current product details
        stmt = conn.createStatement();
        String sql = "SELECT * FROM inventory WHERE product_code = '" + id + "'";
        rs = stmt.executeQuery(sql);

        if (rs.next()) {
            updatedQuantity = rs.getInt("quantity");
            productName = rs.getString("product_name");
            basePrice = rs.getDouble("base_price");
        }

        // Update quantity
        int finalQuantity = updatedQuantity + quantity;
        String updateSql = "UPDATE inventory SET quantity = " + finalQuantity + " WHERE product_code = '" + id + "'";
        stmt.executeUpdate(updateSql);

        // Insert into inword_data
        String insertSql = "INSERT INTO inword_data (product_code, product_name, base_price, vendor_name, quantity, product_date) VALUES ('" + id + "', '" + productName + "', " + basePrice + ", '" + vendorName + "', " + quantity + ", '" + purchaseDate + "')";
        stmt.executeUpdate(insertSql);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<h1 style="text-align: center;">Receipt</h1>
<table border="1" style="width: 100%; text-align: center; border-collapse: collapse;">
    <tr>
        <th>Product ID</th>
        <th>Product Name</th>
        <th>Base Price</th>
        <th>Quantity</th>
    </tr>
    <tr>
        <td><%= id %></td>
        <td><%= productName %></td>
        <td><%= basePrice %></td>
        <td><%= quantity %></td>
    </tr>
    <tr>
        <th colspan="3">Total</th>
        <th><%= basePrice * quantity %></th>
    </tr>
</table>
<br>
<div style="text-align: center;">
    <button onclick="window.print()">Print</button>
</div>

</body>
</html>
