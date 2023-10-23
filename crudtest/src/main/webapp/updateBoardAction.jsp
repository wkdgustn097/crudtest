<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	String boardTitle = request.getParameter("boardTitle");
	String boardContents = request.getParameter("boardContents");
	String boardWriter = request.getParameter("boardWriter");
	int boardPw = Integer.parseInt(request.getParameter("boardPw"));
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "UPDATE board SET board_title = ?, board_contents = ?, board_writer = ?,updatedate = NOW() WHERE board_no=? AND board_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContents);
	stmt.setString(3, boardWriter);
	stmt.setInt(4, boardNo);
	stmt.setInt(5, boardPw);
	System.out.println(stmt+"<--stmt");
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo="+boardNo);
		System.out.println(boardNo+"<--넘어가는 번호");
	} else {
		response.sendRedirect(request.getContextPath()+"/updateBoardForm.jsp?boardNo="+boardNo);
	}
	
	stmt.close();
	conn.close();

%>