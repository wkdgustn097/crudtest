<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Board" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + "<-- boarNo");


	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_contents boardContents, board_writer boardWriter, createdate, updatedate FROM board WHERE board_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	Board board = null;
	
	if(rs.next()){
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.boardTitle = rs.getString("boardTitle");
		board.boardContents = rs.getString("boardContents");
		board.boardWriter = rs.getString("boardWriter");
		board.createdate= rs.getString("createdate");
		board.updatedate = rs.getString("updatedate");
	}
	
	rs.close();
	stmt.close();
	conn.close();
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시판 상세정보</h1>
	<form action="">
		<table border="1">
			<tr>
				<th>board_no<th>
				<td><%=board.boardNo%></td>
			</tr>
			<tr>	
				<th>board_title<th>
				<td><%=board.boardTitle%></td>
			</tr>
			<tr>
				<th>board_contents<th>
				<td><textarea rows="5" cols="33" readonly="readonly"><%=board.boardContents%></textarea></td>
			</tr>
			<tr>
				<th>board_writer<th>
				<td><%=board.boardWriter%></td>
			</tr>
			<tr>
				<th>creaatedate<th>
				<td><%=board.createdate%></td>
			</tr>
			<tr>
				<th>updatedate<th>
				<td><%=board.updatedate%></td>
			</tr>
		</table>
		<div>
			<button><a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=board.boardNo%>">수정</a></button>
			<button><a href="<%=request.getContextPath()%>/deleteBoardForm.jsp?boardNo=<%=board.boardNo%>">삭제</a></button>
			<!-- updateBoardForm : 수정필드와 비밀번호 입력 -->
			<!-- updateBoardAction : 번호와 비밀번호 입력 -->
			<!-- deleteBoardForm : 비밀번호 입력 -->
			<!-- deleteBoardAction : 번호와 비밀번호 입력 -->
			<button><a href="<%=request.getContextPath()%>/boardList.jsp">돌아가기</a></button>
		</div>
	</form>
</body>
</html>