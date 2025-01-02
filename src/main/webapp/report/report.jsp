<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Admin Dashboard | Korsat X Parmaga</title>
    <link rel="stylesheet" href="style.css">
</head>
<style>
    html {
        scroll-behavior: smooth;
    }
</style>
<body>
<%
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
    <div class="container">
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="logo-apple"></ion-icon>
                        </span>
                        <span class="title"></span>
                    </a>
                </li>
                <li>
                    <a href="#1" onclick="toggleSection1()">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Inword Sale</span>
                    </a>
                </li>
                <li>
                    <a href="#2" onclick="toggleSection2()">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">Outword Sale</span>
                    </a>
                </li>
                <li>
                    <a href="#3">
                        <span class="icon">
                            <ion-icon name="chatbubble-outline"></ion-icon>
                        </span>
                        <span class="title">Customers</span>
                    </a>
                </li>
                <li>
                    <a href="#4">
                        <span class="icon">
                            <ion-icon name="help-outline"></ion-icon>
                        </span>
                        <span class="title">Vendors</span>
                    </a>
                </li>
                <li>
                    <a href="#5">
                        <span class="icon">
                            <ion-icon name="settings-outline"></ion-icon>
                        </span>
                        <span class="title">Less quantity items</span>
                    </a>
                </li>
                <li>
                    <a href="http://localhost:8080/cloth_record_store/main/index.jsp">
                        <span class="icon">
                            <ion-icon name="log-out-outline"></ion-icon>
                        </span>
                        <span class="title">BACK</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main">
            <div class="topbar">
                <div class="toggle">
                    <ion-icon name="menu-outline"></ion-icon>
                </div>
                <div class="user">
                    <img src="assets/imgs/customer01.jpg" alt="">
                </div>
            </div>

            <div class="cardBox"></div>

            <section id="1">
                <div id="section1">
                    <div class="details">
                        <div class="recentOrders">
                            <div class="cardHeader">
                                <h2>Total take items in this day</h2>
                                <form action="report.jsp" method="post">
                                    <input type="date" name="date" value="select_date">
                                    <input type="submit" name="submit" value="submit">
                                </form>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <td>product code</td>
                                        <td>product name</td>
                                        <td>base price</td>
                                        <td>vendor name</td>
                                        <td>quantity</td>
                                        <td>product date</td>
                                    </tr>
                                </thead>
                                <tbody>
<%
    if (request.getParameter("submit") != null) {
        String date = request.getParameter("date");
        String sql = "SELECT * FROM `inword_data`";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            if (date.equals(rs.getString("product_date"))) {
%>
                <tr>
                    <td><%= rs.getString("product_code") %></td>
                    <td><%= rs.getString("product_name") %></td>
                    <td><%= rs.getDouble("base_price") %></td>
                    <td><%= rs.getString("vendor_name") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getString("product_date") %></td>
                </tr>
<%
            }
        }
        rs.close();
        stmt.close();
    }
%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                        <button onclick="window.print()">Print</button>
            </section>

            <section id="2">
                <div id="section2">
                    <div class="details">
                        <div class="recentOrders">
                            <div class="cardHeader">
                                <h2>Total sale in this day</h2>
                                <form action="report.jsp" method="post">
                                    <input type="date" name="date1" value="select_date">
                                    <input type="submit" name="submit1" value="submit">
                                </form>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <td>product code</td>
                                        <td>product name</td>
                                        <td>selling price</td>
                                        <td>customer name</td>
                                        <td>quantity</td>
                                        <td>product date</td>
                                    </tr>
                                </thead>
                                <tbody>
<%
    if (request.getParameter("submit1") != null) {
        String date1 = request.getParameter("date1");
        String sql1 = "SELECT * FROM `outword_date`";
        Statement stmt1 = conn.createStatement();
        ResultSet rs1 = stmt1.executeQuery(sql1);
        
        while (rs1.next()) {
            if (date1.equals(rs1.getString("product_date"))) {
%>
                <tr>
                    <td><%= rs1.getString("product_code") %></td>
                    <td><%= rs1.getString("product_name") %></td>
                    <td><%= rs1.getDouble("ceiling_price") %></td>
                    <td><%= rs1.getString("customer_name") %></td>
                    <td><%= rs1.getInt("quantity") %></td>
                    <td><%= rs1.getString("product_date") %></td>
                </tr>
<%
            }
        }
        rs1.close();
        stmt1.close();
    }
%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                        <button onclick="window.print()">Print</button>
            </section>

            <section id="3">
                <div id="section3">
                    <div class="details">
                        <div class="recentOrders">
                            <div class="cardHeader">
                                <h2>Customer Information</h2>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Customer ID</th>
                                        <th>Customer Name</th>
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Birth Date</th>
                                    </tr>
                                </thead>
                                <tbody>
<%
    String sqlCustomers = "SELECT * FROM `customers`";
    Statement stmtCustomers = conn.createStatement();
    ResultSet rsCustomers = stmtCustomers.executeQuery(sqlCustomers);
    
    while (rsCustomers.next()) {
%>
                <tr>
                    <td><%= rsCustomers.getInt("c_id") %></td>
                    <td><%= rsCustomers.getString("c_name") %></td>
                    <td><%= rsCustomers.getString("c_address") %></td>
                    <td><%= rsCustomers.getString("c_email") %></td>
                    <td><%= rsCustomers.getString("c_phone") %></td>
                    <td><%= rsCustomers.getString("c_gender") %></td>
                    <td><%= rsCustomers.getString("birth_date") %></td>
                </tr>
<%
    }
    rsCustomers.close();
    stmtCustomers.close();
%>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>
                </div>
                <button onclick="window.print()">Print</button>
            </section>

            <section id="4">
                <div id="section4">
                    <div class="details">
                        <div class="recentOrders">
                            <div class="cardHeader">
                                <h2>Vendor Information</h2>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Vendor ID</th>
                                        <th>Vendor Name</th>
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Birth Date</th>
                                    </tr>
                                </thead>
                                <tbody>
<%
    String sqlVendors = "SELECT * FROM `vendors`";
    Statement stmtVendors = conn.createStatement();
    ResultSet rsVendors = stmtVendors.executeQuery(sqlVendors);
    
    while (rsVendors.next()) {
%>
                <tr>
                    <td><%= rsVendors.getInt("v_id") %></td>
                    <td><%= rsVendors.getString("v_name") %></td>
                    <td><%= rsVendors.getString("v_address") %></td>
                    <td><%= rsVendors.getString("v_email") %></td>
                    <td><%= rsVendors.getString("v_phone") %></td>
                    <td><%= rsVendors.getString("v_gender") %></td>
                    <td><%= rsVendors.getString("birth_date") %></td>
                </tr>
<%
    }
    rsVendors.close();
    stmtVendors.close();
%>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>
                </div>
                <button onclick="window.print()">Print</button>
            </section>

            <section id="5">
                <div id="section5">
                    <div class="details">
                        <div class="recentOrders">
                            <div class="cardHeader">
                                <h2>Less Quantity</h2>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Product Code</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                    </tr>
                                </thead>
                                <tbody>
<%
    String sqlInventory = "SELECT * FROM `inventory`";
    Statement stmtInventory = conn.createStatement();
    ResultSet rsInventory = stmtInventory.executeQuery(sqlInventory);
    
    while (rsInventory.next()) {
        if (rsInventory.getInt("quantity") <= 20) {
%>
                <tr>
                    <td><%= rsInventory.getString("product_code") %></td>
                    <td><%= rsInventory.getString("product_name") %></td>
                    <td><%= rsInventory.getInt("quantity") %></td>
                </tr>
<%
        }
    }
    rsInventory.close();
    stmtInventory.close();
%>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>
                </div>
                <button onclick="window.print()">Print</button>
            </section>
        </div>
    </div>

    <script>
        let list = document.querySelectorAll(".navigation li");

        function activeLink() {
            list.forEach((item) => {
                item.classList.remove("hovered");
            });
            this.classList.add("hovered");
        }

        list.forEach((item) => item.addEventListener("mouseover", activeLink));

        let toggle = document.querySelector(".toggle");
        let navigation = document.querySelector(".navigation");
        let main = document.querySelector(".main");

        toggle.onclick = function () {
            navigation.classList.toggle("active");
            main.classList.toggle("active");
        };
    </script>
</body>
</html>
