<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	String studentName = request.getParameter("studentName");
	String studentGender = request.getParameter("studentGender");
	String studentBirth = request.getParameter("studentBirth");
	String TeamNo = request.getParameter("teamNo");

    Class.forName("org.mariadb.jdbc.Driver");  // 데이터베이스를 사용할 수 있도록 로딩하는 것
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // db 주소
	String dbuser = "root";                              // db 아이디
	String dbpw = "java1234";                            // db 패스워드
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql ="INSERT INTO student(student_name, student_gender,student_birth,team_no ,createdate, updatedate) VALUES(?,?,?,?,NOW(),NOW())"; // ? : 아직 저기에 다른 값이 들어 올 수 있다.  prinf 에 %d 같은거랑 같음
    PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, studentName);
	stmt.setString(2, studentGender);
	stmt.setString(3, studentBirth);
	stmt.setString(4, TeamNo);
	System.out.println(stmt+"<--stmt");
	int row = stmt.executeUpdate();
	if(row==1) {  // 디버깅 
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}  //  <-- 여기까지가 모델 레이어
	
	// db관련 프로세스 END -> DB자원을 해제  
	
	stmt.close();
	conn.close();
	
	// 리다이렉션  <-- 컨트롤러 레이어
	response.sendRedirect(request.getContextPath()+"/studentList.jsp");
	
%>