<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    HttpSession s = request.getSession();
    // Your existing code...

    String url = "jdbc:mysql://localhost:3306/main";
    String user = "root";
    String password = "";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        out.println("Connection failed: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="stock.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <title>Drop-down Selection Data Load with Ajax, JSP & MySQL</title>
    <script type="text/javascript" src="getData.js"></script>
</head>
<body>
<div class="filter"></div>
<div class="container" style="min-height:500px;">
    <div class=''></div>

    <div class="container">
        <div id="errorMassage"></div>
        <form action="outword2.jsp" method="post">
            <table class="table table-striped hidden" id="recordListing">
                <thead>
                <tr>
                    <th colspan="2">Outword_data</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Purchase Date</td>
                    <td><input type="date" name="pdate"></td>
                </tr>
                <tr>
                    <td>Select Product Code</td>
                    <td>
                        <select id="employee" name="pid" class="form-control">
                            <option value="" selected="selected">Select product code</option>
                            <%
                                try {
                                    String sql = "SELECT product_code, product_name, base_price, seiling_price FROM inventory";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("product_code") %>">
                                <%= rs.getString("product_code") %>
                            </option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch (SQLException e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Customer Name</td>
                    <td>
                        <select name="cid" class="form-control">
                            <option value="" selected="selected">Select Customer Name</option>
                            <%
                                try {
                                    String sql = "SELECT c_id, c_name, c_email, c_phone FROM customers";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("c_name") %>">
                                <%= rs.getString("c_name") %>
                            </option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch (SQLException e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Product Code:</td>
                    <td id="productId"><input type="text" name="pid"></td>
                </tr>
                <tr>
                    <td>Product Name:</td>
                    <td id="productName"><input type="text" name="p"></td>
                </tr>
                <tr>
                    <td>Seiling Price:</td>
                    <td id="seilingPrice"><input type="text" name="p"></td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td><input type="text" name="q"></td>
                </tr>
                <tr>
                    <td> <button type="button"  onclick="history.back()">BACK</button></td>
                    <td><input type="reset" value="Reset"><input type="submit" value="Submit"></td>
                </tr>
                </tbody>
            </table>
        </form>
<%
if (s.getAttribute("status") != null) {
    out.println("<script>alert('" + s.getAttribute("status") + "')</script>");
    s.removeAttribute("status");
}

%>    
    </div>
    <div class="insert-post-ads1" style="margin-top:20px;"></div>
</div>
</body>
</html>
<%
    try {
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        out.println("Error closing connection: " + e.getMessage());
    }
%>
