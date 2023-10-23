<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Board" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("접속성공");
	
	
	int beginRow = 0;
	int rowPerPage = 10;
	String sql = "SELECT board_no AS boardNo, board_title AS boardTitle, board_contents AS boardContents, board_writer AS boardWriter, createdate, updatedate FROM board ORDER BY createdate LIMIT ?,?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
	ResultSet rs = stmt.executeQuery();
	ArrayList<Board>list = new ArrayList<Board>();
	while(rs.next()){
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.boardContents = rs.getString("boardContents");
		b.boardWriter = rs.getString("boardWriter");
		b.createdate = rs.getString("createdate");
		b.updatedate = rs.getString("updatedate");
		list.add(b);
	}
	
	stmt.close();
	conn.close();
	rs.close();

	
%>
</body>
	<ul>
		<li><a href="<%=request.getContextPath() %>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath() %>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath() %>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath() %>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath() %>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>게시판 리스트</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addBoardForm.jsp">게시판 추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>board_no</th>
				<th>board_title</th>
				<th>board_writer</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Board b : list){
		%>
			<tr>
				<td><%=b.boardNo%></td>
				<td>
					<a href="<%=request.getContextPath()%>/boardOne.jsp?boardNo=<%=b.boardNo%>">
							<%=b.boardTitle%>
					</a>
				</td>
				<td><%=b.boardWriter%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</html>