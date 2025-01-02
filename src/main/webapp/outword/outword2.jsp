        <%@ page contentType="text/html;charset=UTF-8" language="java" %> 
        <%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    session.setAttribute("status", null); // Resetting the session status

    String id = request.getParameter("pid");
    String quantityStr = request.getParameter("q");
    String cname = request.getParameter("cid");
    String pdate = request.getParameter("pdate");

    int quantity = Integer.parseInt(quantityStr);
    String pname = null;
    String pselingprice = null;
    int updateValue = 0;
    int finalUpdate = 0;

    String url = "jdbc:mysql://localhost:3306/main";
    String user = "root";
    String password = "";

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Check current inventory
        String sqli = "SELECT * FROM `inventory` WHERE product_code = ?";
        PreparedStatement pstmt = conn.prepareStatement(sqli);
        pstmt.setString(1, id);
        ResultSet result = pstmt.executeQuery();

        if (result.next()) {
            updateValue = result.getInt("quantity");
            pname = result.getString("product_name");
            pselingprice = result.getString("seiling_price");
        }
      
            HttpSession s = request.getSession();
            s.setAttribute("status", null); // Resetting the session status
            // Your existing code...
            if (updateValue == 0 || updateValue < quantity) {
                s.setAttribute("status", "not available quantity..");
                response.sendRedirect("outword.jsp");
                return;
            }
       

        finalUpdate = updateValue - quantity;

        // Update inventory
        String sqlUpdate = "UPDATE `inventory` SET `quantity` = ? WHERE `product_code` = ?";
        PreparedStatement updateStmt = conn.prepareStatement(sqlUpdate);
        updateStmt.setInt(1, finalUpdate);
        updateStmt.setString(2, id);
        updateStmt.executeUpdate();

        // Insert into outword_date
        String sqlInsert = "INSERT INTO `outword_date` (`product_code`, `product_name`, `ceiling_price`, `customer_name`, `quantity`, `product_date`) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(sqlInsert);
        insertStmt.setString(1, id);
        insertStmt.setString(2, pname);
        insertStmt.setString(3, pselingprice);
        insertStmt.setString(4, cname);
        insertStmt.setInt(5, quantity);
        insertStmt.setString(6, pdate);
        insertStmt.executeUpdate();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt</title>
</head>
<body>
    <h1 style="text-align: center;">Receipt</h1>
    <table border="1" style="width: 100%; text-align: center; border-collapse: collapse;">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Ceiling Price</th>
            <th>Purchase Date</th>
            <th>Quantity</th>
        </tr>
        <tr>
            <td><%= id %></td>
            <td><%= pname %></td>
            <td><%= pselingprice %></td>
            <td><%= pdate %></td>
            <td><%= quantity %></td>
        </tr>
        <tr>
            <th colspan="4">Total</th>
            <th><%= Integer.parseInt(pselingprice) * quantity %></th>
        </tr>
    </table>
    <p>Thank you</p>
    <div style="text-align: center;">
        <button onclick="window.print()">Print</button>
    </div>
</body>
</html>
