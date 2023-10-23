<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // int teamNo에 teamNo값 요청한 값 받기
	int boardPw = Integer.parseInt(request.getParameter("boardPw"));
	
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";  // sql delete문 / ? : printf에 %d 같이 변하는 값 
	PreparedStatement stmt = conn.prepareStatement(sql); // 파라미터를 입력 받아 동적인 쿼리문을 실행할 경우
	stmt.setInt(1, boardNo);
	stmt.setInt(2, boardPw);// ?에 대한 순번 첫번째 ?에 teamNo값 넣기
			
	System.out.println(stmt + "<-- stmt");
	int row = stmt.executeUpdate();
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/updateboardForm.jsp?boardNo="+boardNo);
	}
	
	stmt.close();  // stmt 해제
	conn.close();  // conn 해제
	


%>