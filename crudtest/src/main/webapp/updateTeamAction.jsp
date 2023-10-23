<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));	
	String teamName = request.getParameter("teamName");
	int teamCount = Integer.parseInt(request.getParameter("teamCount"));
	String teamBegin = request.getParameter("teamBegin");
	String teamEnd = request.getParameter("teamEnd");
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "UPDATE team SET team_name = ?, team_count = ?, team_begin = ?,team_end = ?, updatedate = NOW() WHERE team_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, teamName);
	stmt.setInt(2, teamCount);
	stmt.setString(3, teamBegin);
	stmt.setString(4, teamEnd);
	stmt.setInt(5, teamNo);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/teamList.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/updateTeamForm.jsp?=teamNo="+teamNo);
	}

%>