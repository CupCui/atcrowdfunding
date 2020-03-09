<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content=""> 
    <meta name="author" content="">
	<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form id="loginForm" class="form-signin" role="form" action="${PATH}/doLogin" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
		  
		  <c:if test="${not empty message }">
			  <div class="form-group has-success has-feedback">
					${message}
			  </div> 
		  </c:if>
		  
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="loginacct" name="loginacct" value="${param.loginacct }" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div> 
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="userpswd" name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>		  
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="reg.html">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <%-- 静态包含：被包含的页面，不会独立生成.java   .class文件。与当前jsp页面一起进行编译 --%>
    <%@ include file="/WEB-INF/jsp/common/js.jsp" %>
    
    <%--动态包含：当前页面和被包含页面，都会生成独立.java  .class文件
    			被包含页面内容总是变化（动态）的，需要单独编译。避免让当前页面一起参与编译。
     --%>
    <%-- <jsp:include page="/WEB-INF/jsp/common/js.jsp"></jsp:include> --%>
    <script>
    function dologin() {
        $("#loginForm").submit();
    }
    </script>
  </body>
</html>