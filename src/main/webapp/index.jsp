<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>index.jsp</h1>
		<%
			// MVC ������Ʈ�� ��������
			// �ش� ������Ʈ���� ���డ���� ������ jsp ������
			
			// -> ����, �����Ų ������ �ּҰ� ~.jsp ���� => �߸��� ����
			
// 			response.sendRedirect("./itwill.me");
// 			response.sendRedirect("./MemberJoin.me");
// 			response.sendRedirect("./MemberLogin.me");
			response.sendRedirect("./Main.me");
		%>
	</body>
</html>