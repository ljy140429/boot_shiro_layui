<%--  Created by IntelliJ IDEA.  
User: Lenovo  
Date: 2019/7/1  
Time: 10:30 
To change this template use File | Settings | File Templates.--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://shiro.apache.org/tags" %>
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
        <form class="layui-form" action="/user/login" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">账号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码:</label>
                <div class="layui-input-inline">
                    <input type="text" name="userPswd" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="">登陆</button>
                    <button type="reset" class="layui-btn layui-btn-primary">
                        <a href="/register.jsp">
                        注册
                        </a>
                    </button>
                </div>
            </div>
        </form>
</body>
</html>