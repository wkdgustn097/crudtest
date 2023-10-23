<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>팀추가</h1>
	<form action="<%=request.getContextPath()%>/addTeamAction.jsp">
		<table border="1">
			<tr>
				<th>팀 이름</th>
				<td>
					<input type="text" name="teamName">
				</td>
			</tr>
			<tr>
				<th>인원 수</th>
				<td>
					<input type="text" name="teamCount">
				</td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="teamBegin">
				</td>
			</tr>
						<tr>
				<th>종료일</th>
				<td>
					<input type="date" name="teamEnd">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">추가</button>
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>