<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));	
	String studentName = request.getParameter("studentName");
	String studentGender = request.getParameter("studentGender");
	String studentBirth = request.getParameter("studentBirth");
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "UPDATE student SET student_name = ?, student_gender = ?, student_birth = ?,updatedate = NOW() WHERE student_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, studentName);
	stmt.setString(2, studentGender);
	stmt.setString(3, studentBirth);
	stmt.setInt(4, studentNo);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/studentOne.jsp?studentNo="+studentNo);
		System.out.println(studentNo+"<--넘어가는 번호");
	} else {
		response.sendRedirect(request.getContextPath()+"/updateStudentForm.jsp?studentNo="+studentNo);
	}
	
	stmt.close();
	conn.close();

%>