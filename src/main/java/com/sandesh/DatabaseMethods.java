package com.sandesh;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DatabaseMethods {

	//------------------------------------------------------------------------------------
		public static Connection conction() {
			Connection con = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
			 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/main","root","");
				
				if(con!=null)
				{
					System.out.println("connected...");
					return con;
				}
						
			}catch(Exception e) {
				e.printStackTrace();
			}
			return con;
		}
		
		//--------------------------------------------------------------------------------------
		
		
		public static boolean loginInadmin(String u, String p)
		{
			boolean result=false;
			try
			{
		Connection con = conction();
			PreparedStatement st=con.prepareStatement("select * from users where id=? and pass=?");
			st.setString(1, u);
			st.setString(2, p);
			
			ResultSet rs=st.executeQuery();
			
		     result =rs.next();
			
			}
			catch (Exception e) {
				e.printStackTrace();// TODO: handle exception
			}
		   return result;
		}
		
		//---------------
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
//--------------------------------------------------------------------------------------------------------------------------------
	public static boolean CustomerRegistration(String vname, String vemail, String vadd, String vphone, String vdob,
			String vgender) {
		boolean result = false;
		
		try {
			Connection con = conction();
			String q = "INSERT INTO `customers` (`c_id`, `c_name`, `c_address`, `c_email`, `c_phone`, `c_gender`, `birth_date`) VALUES (NULL, ?, ?, ?, ?, ?, ?)";
			PreparedStatement st=con.prepareStatement(q);
			 st.setString(1, vname);
			 st.setString(2, vadd);
			 st.setString(3, vemail);
			 st.setString(4, vphone);
			 st.setString(5, vdob);
			 st.setString(6, vgender);
			 int rs=st.executeUpdate();
				if(rs!=0) {
					result = true;
				}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	//--------------------------------------------------------------------------------------------------------------------------------
		public static boolean VendorRegistration(String vname, String vemail, String vadd, String vphone, String vdob,
				String vgender) {
			boolean result = false;
			
			try {
				Connection con = conction();
				String q =  "INSERT INTO `vendors` (`v_id`, `v_name`, `v_address`, `v_email`, `v_phone`, `birth_date`, `v_gender`) VALUES (NULL,?,?,?,?,?,?)"; 
				PreparedStatement st=con.prepareStatement(q);
				 st.setString(1, vname);
				 st.setString(2, vadd);
				 st.setString(3, vemail);
				 st.setString(4, vphone);
				 st.setString(5, vdob);
				 st.setString(6, vgender);
				 int rs=st.executeUpdate();
					if(rs!=0) {
						result = true;
					}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}

}
