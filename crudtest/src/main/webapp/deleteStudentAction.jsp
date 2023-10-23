<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	System.out.println(studentNo + "<--studentNo");
	
	Class.forName("org.mariadb.jdbc.Driver");  // 데이터베이스를 사용할 수 있도록 로딩하는 것
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // db 주소
	String dbuser = "root";                              // db 아이디
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM student WHERE student_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, studentNo);
	System.out.println(stmt + "<-- stmt");
	int row = stmt.executeUpdate();
	if(row==1) {  // 디버깅 
		System.out.println("삭제성공");
	} else {
		System.out.println("삭제실패");
	}  //  <-- 여기까지가 모델 레이어

	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+"/studentList.jsp");
%>