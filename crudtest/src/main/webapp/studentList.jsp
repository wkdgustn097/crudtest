<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Student" %>
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
	
	String sql = "SELECT student_no AS studentNo, student_name AS studentName, student_gender AS studentGender, student_birth AS studentBirth, createdate, updatedate FROM student";
	// 실행할 sql 문 ↑
	PreparedStatement stmt = conn.prepareStatement(sql); // 파라미터를 입력 받아 동적인 쿼리문을 실행할 경우
	ResultSet rs = stmt.executeQuery(); // select등 리턴 값이 필요한 쿼리문일 때 사용
	ArrayList<Student> list = new ArrayList<Student>();
	while(rs.next()){
		Student s = new Student();
		s.studentNo = rs.getInt("studentNo");
		s.studentName = rs.getString("studentName");
		s.studentGender  = rs.getString("studentGender");
		s.studentBirth = rs.getString("studentBirth");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		list.add(s);
	}
	
	   rs.close();
	   stmt.close();
	   conn.close();
%>
</body>
	<ul>
		<li><a href="<%=request.getContextPath() %>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath() %>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath() %>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath() %>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath() %>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>학생 리스트</h1>
	<div>
		<a href="<%=request.getContextPath() %>/addStudentForm.jsp">학생 추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>student_no</th>
				<th>student_name</th>
				<th>student_gender</th>
				<th>student_birth</th>
				<th>createdate</th>
				<th>updatedate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Student s : list){
			%>
				<tr>
					<td><%=s.studentNo%></td>
				<td>
					<a href="<%=request.getContextPath()%>/studentOne.jsp?studentNo=<%=s.studentNo%>">
							<%=s.studentName%>
					</a>
				</td>
					<td><%=s.studentGender%></td>
					<td><%=s.studentBirth%></td>
					<td><%=s.createdate%></td>
					<td><%=s.updatedate%></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
</html>