<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Team" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("접속성공");
	
	String sql = "SELECT team_no AS teamNo, team_name AS teamName, team_count AS teamCount, team_begin AS teamBegin, team_end AS teamEnd, createdate, updatedate FROM team";
	// 실행할 sql 문 ↑
	PreparedStatement stmt = conn.prepareStatement(sql); // 파라미터를 입력 받아 동적인 쿼리문을 실행할 경우
	ResultSet rs = stmt.executeQuery(); // select등 리턴 값이 필요한 쿼리문일 때 사용
	ArrayList<Team> list = new ArrayList<Team>();
	while(rs.next()){
		Team t = new Team();
		t.teamNo = rs.getInt("teamNo");
		t.teamName = rs.getString("teamName");
		t.teamCount = rs.getInt("teamCount");
		t.teamBegin = rs.getString("teamBegin");
		t.teamEnd = rs.getString("teamEnd");
		t.createdate = rs.getString("createdate");
		t.updatedate = rs.getString("updatedate");
		list.add(t);
	}
%>
</body>
	<ul>
		<li><a href="<%=request.getContextPath() %>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath() %>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath() %>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath() %>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath() %>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>팀 리스트</h1>
	<div>
		<a href="<%=request.getContextPath() %>/addTeamForm.jsp">팀추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>team_no</th>
				<th>team_name</th>
				<th>team_count</th>
				<th>team_begin</th>
				<th>team_end</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Team t : list){
			%>
				<tr>
					<td><%=t.teamNo%></td>
					<td><%=t.teamName%></td>
					<td><%=t.teamCount%></td>
					<td><%=t.teamBegin%></td>
					<td><%=t.teamEnd%></td>
					<td><%=t.createdate%></td>
					<td><%=t.updatedate%></td>
					<td>
						<a href = "<%=request.getContextPath()%>/updateTeamForm.jsp?teamNo=<%=t.teamNo%>">수정</a>
					</td>
					<td>
						<a href = "<%=request.getContextPath()%>/deleteTeamAction.jsp?teamNo=<%=t.teamNo%>">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
</html>