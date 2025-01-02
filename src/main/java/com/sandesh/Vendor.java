package com.sandesh;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Vendor
 */
@WebServlet("/Vendor")
public class Vendor extends HttpServlet {
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

        HttpSession session = request.getSession();
        
		String vname = request.getParameter("name");
		String vemail = request.getParameter("email");
		String vadd = request.getParameter("address");
		String vphone = request.getParameter("phone");
		String vdob = request.getParameter("bdate");
		String vgender = request.getParameter("gender");
		//doGet(request, response);
		
		boolean r = DatabaseMethods.VendorRegistration(vname, vemail,vadd,vphone,vdob,vgender);

		if(r) {

            session.setAttribute("message", "Item saved in database.");
    		response.sendRedirect("vendor/vendordata.jsp");
    		
		}
		else {
			response.sendRedirect("data is not submited");
		}
	
		
		//doGet(request, response);
	}

}
