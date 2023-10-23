<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	String BoardTitle = request.getParameter("boardTitle");
	String BoardContents = request.getParameter("boardContents");
	String BoardWriter = request.getParameter("boardWriter");
	int BoardPw = Integer.parseInt(request.getParameter("boardPw"));
	
    Class.forName("org.mariadb.jdbc.Driver");  // 데이터베이스를 사용할 수 있도록 로딩하는 것
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // db 주소
	String dbuser = "root";                              // db 아이디
	String dbpw = "java1234";          
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO board(board_title, board_contents, board_writer, board_pw,createdate, updatedate) VALUES (?, ?, ?, ?,NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, BoardTitle);
	stmt.setString(2, BoardContents);
	stmt.setString(3, BoardWriter);
	stmt.setInt(4, BoardPw);
	System.out.println(stmt+"<--stmt");
	int row = stmt.executeUpdate();   // insert, update, delete등 리턴 값이 필요 없는 쿼리문일 때 사용
	if(row==1) {  // 디버깅 
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	stmt.close();
	conn.close();
	
	// 리다이렉션
	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	
%>