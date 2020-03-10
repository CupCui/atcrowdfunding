<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%--  request.getRequestDispater("/login").forward(request,response); 后台路径 --%>
<%-- <jsp:forward page="${PATH}/login"></jsp:forward> 不能增加${PATH}
		后台路径：服务器端资源内部查找路径。斜杠开头表示当前上下文路径。
		
--%>

<%-- <script src="${PATH}/static/bootstrap/js/bootstrap.min.js"></script> 
		前台路径：浏览器端向服务器发起的请求资源路径。斜杠开头表示服务器根路径 ROOT。
		
		src="/static/bootstrap/js/bootstrap.min.js"  表示从ROOT目录下查找资源
		src="${PATH}/static/bootstrap/js/bootstrap.min.js" 表示从当前应用上下文路径查找资源
		
		response.sendRediect(request.getContextPath()+"/abc.jsp"); //会发起二次请求，依然从浏览器端发起的，这是一个前台路径
--%>

<jsp:forward page="/login"></jsp:forward>
</body>
</html>