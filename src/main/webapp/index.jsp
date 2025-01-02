<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel = "stylesheet" type="text/css" href="css/style1.css">
<title>login page</title>
</head>
<body>
    
        <div class="wrapper">
                <form method="post" action="AdminLogin" > 
                   
                    <div class="input-box">
                        <input type="text" name="username" required>
                        <label><b>AdminID</b></label>
                    </div>
                    <div class="input-box">
                        <input type="password" name="password" required>
                        <label><b>Password</b></label>
                    </div>
                    <button type="submit" class="btn">login</button>
                </form>
            <%
        // Display an alert if the session attribute 'status' is set
        if (session.getAttribute("status") != null) {
    %>
        <script>
            alert('Password is not match');
        </script>
    <%
            // Clear the session attribute after displaying the alert
            session.removeAttribute("status");
        }
    %>
            </div>
</body>
</html>