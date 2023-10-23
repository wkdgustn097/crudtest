<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Emp" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int empNo = Integer.parseInt(request.getParameter("empNo"));

	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234"; 							 // pw
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT emp_no empNo, emp_name empName, createdate, updatedate FROM emp WHERE emp_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, empNo);
	ResultSet rs = stmt.executeQuery();
	Emp emp = null;
	if(rs.next()){
		emp = new Emp();
		emp.empNo = rs.getInt("empNo");
		emp.empName = rs.getString("empName");
		emp.createdate = rs.getString("createdate");
		emp.updatedate = rs.getString("updatedate");
		
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Emp 수정</h1>
	<form action="<%=request.getContextPath()%>/updateEmpAction.jsp">
		<table border="1">
			<tr>
				<td>emp_no<td>
				<td>
					<input type="text" name="empNo" value="<%=emp.empNo%>" readonly="readonly"> <!-- readonly 값을 바꿀 수 없음 -->
				</td>
			</tr>
			<tr>
				<td>emp_name<td>
				<td>
					<input type="text" name="empName" value="<%=emp.empName%>"> <!-- 원래 값 보여주기 -->
				</td>
			</tr>
			<tr>
				<td>creaatedate<td>
				<td><%=emp.createdate%></td>
			</tr>
			<tr>
				<td>updatedate<td>
				<td><%=emp.updatedate%></td>
			</tr>
			<tr>
				<td colsapn="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>