<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Emp" %>
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
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // db 주소
	String dbuser = "root";                              // db 아이디
	String dbpw = "java1234";                            // db 패스워드
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("접속성공");
	
	String sql = "SELECT emp_no AS empNo, emp_name AS empName, createdate, updatedate FROM emp";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	// <-- 여기까지가 모델 레이어 
	// rs, conn을 해제하고 싶지만 뷰 에서 rs를 사용하기 때문에 해제하지 못함
	// conn은 rs랑 묶여있기 때문에 conn을 해제하면 rs도 해제되기 때문에 해제못함
	// 그럼 해제전에 ResultSet -> ArrayList로 변형해서 카피함 -> 자원해제
	// DB Emp테이블 행의 집합(ResultSet)을 -> JAVA Emp클래스 타입의 집합(ArrayList)으로
	// 특별한 것에서 범용적인 List로 변환함
	ArrayList<Emp> list = new ArrayList<Emp>();
	while(rs.next()){
		Emp e = new Emp(); // 결과행의 수만큼 Emp 객체 필요
		e.empNo = rs.getInt("empNo");
		e.empName = rs.getString("empName");
		e.createdate = rs.getString("createdate");
		e.updatedate = rs.getString("updatedate");
		list.add(e);
	}
	
	
	// 뷰 레이어
%>
</body>
	<ul>
		<li><a href="<%=request.getContextPath() %>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath() %>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath() %>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath() %>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath() %>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>직원 리스트</h1>
	<div>
		<a href="<%=request.getContextPath() %>/addEmpForm.jsp">직원추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>emp_no</th>
				<th>emp_name</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>석재</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Emp e : list){
			%>
				<tr>
					<td><%=e.empNo%></td>
					<td><%=e.empName%></td>
					<td><%=e.createdate%></td>
					<td><%=e.updatedate%></td>
					<td>
						<a href="<%=request.getContextPath()%>/updateEmpForm.jsp?empNo=<%=e.empNo%>">수정</a>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/deleteEmpAction.jsp?empNo=<%=e.empNo%>">삭제</a>
					</td>
				</tr>
					
			<%
				}
			%>
		</tbody>
	</table>

</html>