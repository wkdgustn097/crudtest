<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Student" %>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));

	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT student_no AS studentNo, student_name AS studentName, student_gender AS studentGender, student_birth AS studentBirth, createdate, updatedate FROM student WHERE student_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, studentNo);
	ResultSet rs = stmt.executeQuery();
	
	Student student = null;
	if(rs.next()){
		student = new Student();
		student.studentNo = rs.getInt("studentNo");
		student.studentName = rs.getString("studentName");
		student.studentGender = rs.getString("studentGender");
		student.studentBirth = rs.getString("studentBirth");
		student.createdate= rs.getString("createdate");
		student.updatedate = rs.getString("updatedate");
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
	<h1>학생 정보 수정</h1>
	<form action="<%=request.getContextPath()%>/updateStudentAction.jsp">
		<table border="1">
			<tr>
				<th>student_no<th>
				<td>
					<input type="text" name="studentNo" value="<%=student.studentNo%>" readonly="readonly"> <!-- readonly 값을 바꿀 수 없음 -->
				</td>
			</tr>
			<tr>
				<th>student_name<th>
				<td>
					<input type="text" name="studentName" value="<%=student.studentName%>"> 
				</td>
			</tr>
			<tr>
				<th>student_gender<th>
				<td>
					<input type="text" name="studentGender" value="<%=student.studentGender%>">
				</td>
			</tr>
			<tr>
				<th>student_birth<th>
				<td>
					<input type="date" name="studentBirth" value="<%=student.studentBirth%>">
				</td>
			</tr>
			<tr>
				<th>creaatedate<th>
				<td><%=student.createdate%></td>
			</tr>
			<tr>
				<th>updatedate<th>
				<td><%=student.updatedate%></td>
			</tr>
		</table>
			<div>
				<button type="submit">수정</button>
			</div>
	</form>
</body>
</html>