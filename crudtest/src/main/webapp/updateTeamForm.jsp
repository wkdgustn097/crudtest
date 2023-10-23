<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Team" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));

	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT team_no teamNo, team_name teamName, team_count teamCount, team_begin teamBegin ,team_end teamEnd, createdate, updatedate FROM team WHERE team_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, teamNo);
	ResultSet rs = stmt.executeQuery();
	Team team = null;
	if(rs.next()){
		team = new Team();
		team.teamNo = rs.getInt("teamNo");
		team.teamName = rs.getString("teamName");
		team.teamCount = rs.getInt("teamCount");
		team.teamBegin = rs.getString("teamBegin");
		team.teamEnd = rs.getString("teamEnd");
		team.createdate = rs.getString("createdate");
		team.updatedate = rs.getString("updatedate");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시판 수정</h1>
	<form action="<%=request.getContextPath()%>/updateTeamAction.jsp">
		<table border="1">
			<tr>
				<td>team_no<td>
				<td>
					<input type="text" name="teamNo" value="<%=team.teamNo%>" readonly="readonly"> <!-- readonly 값을 바꿀 수 없음 -->
				</td>
			</tr>
			<tr>
				<td>team_name<td>
				<td>
					<input type="text" name="teamName" value="<%=team.teamName%>"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
			<tr>
				<td>team_count<td>
				<td>
					<input type="text" name="teamCount" value="<%=team.teamCount%>"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
			<tr>
				<td>team_begin<td>
				<td>
					<input type="text" name="teamBegin" value="<%=team.teamBegin%>"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
			<tr>
				<td>team_end<td>
				<td>
					<input type="text" name="teamEnd" value="<%=team.teamEnd%>"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
			<tr>
				<td>creaatedate<td>
				<td><%=team.createdate%></td>
			</tr>
			<tr>
				<td>updatedate<td>
				<td><%=team.updatedate%></td>
			</tr>
			<tr>
				<td colsapn="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>