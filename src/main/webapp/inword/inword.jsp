<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="stock.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <title>Drop-down Selection Data Load with AJAX, JSP & MySQL</title>
    <script type="text/javascript" src="getData.js"></script>
</head>
<body>
<div class="filter"></div>
<div class="container" style="min-height:500px;">
    <div class="container">
        <div id="errorMassage"></div>
        <form action="inword2.jsp" method="post">
            <table class="table table-striped" id="recordListing">
                <thead>
                    <tr>
                        <th colspan="2">Inword_data</th>
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
                                    Connection conn = null;
                                    Statement stmt = null;
                                    ResultSet rs = null;
                                    String url = "jdbc:mysql://localhost:3306/main";
                                    String user = "root";
                                    String password = "";
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        conn = DriverManager.getConnection(url, user, password);
                                        stmt = conn.createStatement();
                                        String sql = "SELECT product_code, product_name FROM inventory";
                                        rs = stmt.executeQuery(sql);
                                        while (rs.next()) {
                                            String productCode = rs.getString("product_code");
                                %>
                                            <option value="<%= productCode %>"><%= productCode %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Vendor Name</td>
                        <td>
                            <select name="vid" class="form-control">
                                <option value="" selected="selected">Select Vendor Name</option>
                                <%
                                    try {
                                        conn = DriverManager.getConnection(url, user, password);
                                        stmt = conn.createStatement();
                                        String sql = "SELECT v_name FROM vendors";
                                        rs = stmt.executeQuery(sql);
                                        while (rs.next()) {
                                            String vendorName = rs.getString("v_name");
                                %>
                                            <option value="<%= vendorName %>"><%= vendorName %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
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
                        <td id="productName"><input type="text" name="pname"></td>
                    </tr>
                    <tr>
                        <td>Base Price:</td>
                        <td id="basePrice"><input type="text" name="pbaseprice"></td>
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
       
    </div>
</div>
</body>
</html>
