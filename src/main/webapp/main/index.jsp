<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page session="true" %>
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
<html lang="en"> 

<head> 
	<meta charset="UTF-8"> 
	<meta http-equiv="X-UA-Compatible"
		content="IE=edge"> 
	<meta name="viewport"
		content="width=device-width, 
				initial-scale=1.0"> 
	<title>cloth Management System</title> 
	<link rel="stylesheet"
		href="style.css"> 
	<link rel="stylesheet"
		href="responsive.css"> 

		<link rel="stylesheet"
		href="data.css"> 
</head> 

<body> 
	<%

	
    String userProfile = (String) session.getAttribute("user_id");
    String userPass = (String) session.getAttribute("user_pass");

    if (userProfile == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
	%>
	<!-- for header part -->
	<header> 

		<div class="logosec"> 
			<div class="logo">cloth store management</div> 
			<img src= "1.png"
				class="icn menuicn"
				id="menuicn"
				alt="menu-icon"> 
		</div> 
		

		<div class="message"> 
			 <a href="http://localhost:8080/cloth_record_store/LogoutServlet">
			<img src= "logout.png"
				class="icn"
				alt=""> </a>
				Welcome To <%= userProfile %>
				<img src= "line.png"
				class="icn"
				alt="">
				
				
				
					<div class="dp"> 
					    <img src="<%= userProfile.equals("sandesh") && userPass.equals("sonu@1085") ? "sonu.jpeg" : "rimzim1.jpeg" %>" class="dpicn" alt="dp">
			</div>

			
		</div> 

	</header> 

	<div class="main-container"> 
		<div class="navcontainer"> 
			<nav class="nav"> 
				<div class="nav-upper-options"> 
					<div class="nav-option option1"> 
						<img src= "dashbord.png"
							class="nav-img"
							alt="dashboard"> 
						<h3> Dashboard</h3> 
					</div> 
					<a href="http://localhost:8080/cloth_record_store/data/data.jsp">
					<div class="option2 nav-option"> 
						<img src= "stock.png"
							class="nav-img"
							alt="articles"> 
						<h3> stock</h3> 
					</div> 
					</a>

					<a href="http://localhost:8080/cloth_record_store/inword/inword.jsp">
					<div class="nav-option option4"> 
						<img src= "inword.png"
							class="nav-img"
							alt="institution"> 
						<h3> Inward</h3> 
					</div> 	
				    </a>

					<a href="http://localhost:8080/cloth_record_store/outword/outword.jsp">
					<div class="nav-option option3"> 
						<img src= "outword.png"
							class="nav-img"
							alt="report"> 
						<h3> Outward</h3> 
					</div> 
                  </a>

				  <a href="http://localhost:8080/cloth_record_store/report/report.jsp">
					<div class="nav-option option5"> 
						<img src= "report.png"
							class="nav-img"
							alt="blog"> 
						<h3> Report</h3> 
					</div> 
					</a>

					<a href="http://localhost:8080/cloth_record_store/items/getitem.jsp">
					<div class="nav-option option6"> 
						<img src= "additem.png"
							class="nav-img"
							alt="settings"> 
						<h3> Add Item</h3> 
					</div> </a>

					<a href="http://localhost:8080/cloth_record_store/items/deleteitems.jsp">
					<div class="nav-option option6"> 
						<img src= "delete.png"
							class="nav-img"
							alt="settings"> 
						<h3> Delete Item</h3> 
					</div> </a>

					<a href="http://localhost:8080/cloth_record_store/LogoutServlet">
						<div class="nav-option logout"> 
							<img src= "logout.png"
								class="nav-img"
								alt="logout"> 
							<h3>logout</h3>
						</div> 
						</a>
				</div> 
			</nav> 
		</div> 
		<div class="main"> 

			<div class="searchbar2"> 
				<input type="text"
					name=""
					id=""
					placeholder="Search"> 
				<div class="searchbtn"> 
				<img src= "search.png"
						class="icn srchicn"
						alt="search-button"> 
				</div> 
			</div> 

			<div class="box-container"> 
			<a href="http://localhost:8080/cloth_record_store/data/data.jsp">
				<div class="box box1"> 
					<div class="text"> 
						<h2 class="topic-heading"></h2> 
						<h2 class="topic">Final stock</h2> 
					</div> 

					<img src= "finalstock.png"
						alt="Views"> 
				</div> </a>

				
				<a href="http://localhost:8080/cloth_record_store/vendor/vendordata.jsp">				
				<div class="box box3"> 
					<div class="text"> 
						<h2 class="topic-heading"></h2> 
						<h2 class="topic">Vendor</h2> 
					</div> 

					<img src= "vendor.png";
						alt="comments"> 
				</div> </a>

				<a href="http://localhost:8080/cloth_record_store/customer/customerdata.jsp">				
				<div class="box box4"> 
					<div class="text"> 
						<h2 class="topic-heading"></h2> 
						<h2 class="topic">Customer</h2> 
					</div> 

					<img src= "customer1.png" alt="published"> 
				</div> 
			</a>
			</div> 
			
			<div class="report-container"> 
				<div class="report-header"> 
					<h1 class="recent-Articles">Low quantity of Items</h1> 

			<div class="searchbar"> 
			    <input type="text"placeholder="Search" id="myInput" onkeyup="searchfun()"> 
			    <div class="searchbtn"> 
			    <img src= "searchicon.png"class="icn srchicn"alt="search-icon"> </div> 
		    </div> 
				</div> 	
			     <div>
		        <table id="myTable"> 
		                <tr>
							<th>product code</th>
							<th>product name</th>
							<th>quaintity</th>
							
						</tr>		
<%

while(rs.next())
{
	int num = 0;
    String str = rs.getString("quantity");
    num = Integer.parseInt(str);
    if(num <= 20)
    {
%>						
						<tr>
							<td><%= rs.getString("product_code") %></td>
							<td><%= rs.getString("product_name") %></td>
							<td><%= rs.getString("quantity") %></td>
							
						</tr>
	<%
    }
}
	%>							
				
			</table>
		  </div>
		</div>
		<script src="index.js"></script> 
</body> 
</html>
    