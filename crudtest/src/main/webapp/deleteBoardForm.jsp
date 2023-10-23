<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Board" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT board_no boardNo FROM board WHERE board_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	Board board = null;
	if(rs.next()){
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시판 삭제</h1>
	<form action="<%=request.getContextPath()%>/deleteBoardAction.jsp">
		<table border="1">
			<tr>
				<th>board_no<th>
				<td>
					<input type="text" name="boardNo" value="<%=board.boardNo%>" readonly="readonly"> <!-- readonly 값을 바꿀 수 없음 -->
				</td>
			</tr>
			<tr>
				<th>board_pw<th>
				<td>
					<input type="password" name="boardPw"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
		</table>
			<div>
				<button type="submit">삭제</button>
			</div>
	</form>
</body>
</html>