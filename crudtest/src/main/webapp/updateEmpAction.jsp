<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int empNo = Integer.parseInt(request.getParameter("empNo"));	
	String empName = request.getParameter("empName");
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "UPDATE emp SET emp_name = ?, updatedate = NOW() WHERE emp_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empName);
	stmt.setInt(2, empNo);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/empList.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/updateEmpForm.jsp?=empNo="+empNo);
	}

%>