<%--  Created by IntelliJ IDEA.  
User: Lenovo  
Date: 2019/7/4  
Time: 17:53 
To change this template use File | Settings | File Templates.--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>标题</title>
    <script>
        function f() {
        }
    </script>
</head>
<body>
<h1><font color="red">${msg}</font></h1>
<form action="/user/zhuCe" method="post">
    用户名：<input type="text" name="userName">
    <br>
    密码：<input type="password" name="userPswd">
    <br>
    <input type="submit" value="注册">
</form>
</body>
</html>