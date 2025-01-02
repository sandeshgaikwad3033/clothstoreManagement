<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/main","root","");

if(con!=null)
{
	//System.out.println("connected...");
}
PreparedStatement st=con.prepareStatement("select * from inventory");
ResultSet rs = st.executeQuery();


%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="stock.css">;
    </head>
    <body>
        <div class="filter">

        </div>

        <table>
            <tr>
                <th>product code</th>
                <th>product name</th>
                <th>base price</th>
                <th>seilin price</th>
                <th>product date</th>
                <th>qantity</th>
            </tr>
            <%
int num=0;
            while(rs.next())
            {
            	 %>
                <tr>
                <td><%= rs.getString("product_code") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getString("base_price") %></td>
                <td><%= rs.getString("seiling_price") %></td>
                <td><%= rs.getString("product_date") %></td>
                <td><%= rs.getString("quantity") %></td>
            </tr>
            <%
            String str = rs.getString("quantity");
            num += Integer.parseInt(str);
            }
            %>
            <tr>
                <th>
          <button type="button"  onclick="history.back()">BACK</button></th>
                <th colspan="4">Total:</th>
                <th><%= num%></th>
                
        </tr>
          
        </table>
    </body>
</html>