<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<%
	int teamNo = Integer.parseInt(request.getParameter("teamNo")); // int teamNo에 teamNo값 요청한 값 받기
	System.out.println(teamNo + "<--teamNo"); // 디버깅
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql1 = "SELECT * FROM student WHERE team_no=?";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, teamNo);
	ResultSet rs1 = stmt1.executeQuery();
	if(rs1.next()) { // 삭제할 팀엥 학생이 존재하므로 더이상 코드진행 X / 팀을 삭제할려는데 팀 안에 학생이 있으니 팀 삭제 불가
		response.sendRedirect(request.getContextPath()+"/teamList.jsp");
		return;
	}
	
	
	
	String sql2 = "DELETE FROM team WHERE team_no=?";  // sql delete문 / ? : printf에 %d 같이 변하는 값 
	PreparedStatement stmt2 = conn.prepareStatement(sql2); // 파라미터를 입력 받아 동적인 쿼리문을 실행할 경우
	stmt2.setInt(1, teamNo); // ?에 대한 순번 첫번째 ?에 teamNo값 넣기
	System.out.println(stmt2 + "<-- stmt");
	int row = stmt2.executeUpdate();
	if(row==1) {  // 디버깅 
		System.out.println("삭제성공");
	} else {
		System.out.println("삭제실패");
	}  
	
	stmt2.close();  // stmt 해제
	conn.close();  // conn 해제
	response.sendRedirect(request.getContextPath()+"/teamList.jsp");
	
	   conn.close();
%>