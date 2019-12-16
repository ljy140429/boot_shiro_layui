<%--  Created by IntelliJ IDEA.  
User: Lenovo  
Date: 2019/7/2  
Time: 8:25 
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
    <link rel="stylesheet" href="/webjars/layui/2.4.5/css/layui.css">
    <script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="/webjars/layui/2.4.5/layui.js"></script>
    <script>
        function f() {
        }
    </script>
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">用户权限test</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    当前用户：<s:principal></s:principal>
                </a>
            </li>
            <li class="layui-nav-item"><a href="/user/logout">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <s:hasPermission name="/user/select">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="side-nav-class"
                        data-title="用户列表" data-id="yhgl" data-url="/user/toyhgl">用户列表</a></dd>
                    </dl>
                </li>
                </s:hasPermission>
                <s:hasRole name="vipuser">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">角色</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="side-nav-class"
                               data-title="角色列表" data-id="jsgl" data-url="/jue/tolist">角色列表</a></dd>
                    </dl>
                </li>
                </s:hasRole>
                <s:hasRole name="supervipuser">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">权限</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="side-nav-class"
                               data-title="权限列表" data-id="qxgl" data-url="/per/tolist">权限列表</a></dd>
                    </dl>
                </li>
                </s:hasRole>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <%-- 选项卡主体  --%>
        <div class="layui-tab" lay-filter="myTabs" lay-allowclose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="11">欢迎页面</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <h1>
                        <font color="red">
                    <font color="lime">当前用户权限：</font>
                    <s:hasRole name="user">-普通用户-</s:hasRole>
                    <s:hasRole name="superuser">-高级用户-</s:hasRole>
                    <s:hasRole name="vipuser">-特权用户-</s:hasRole>
                    <s:hasRole name="supervipuser">-系统管理员-</s:hasRole>
                        </font>
                    </h1>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
        var $ = layui.jquery;

        //触发事件
        var active = {
            tabAdd: function(title,url,id){
                //新增一个Tab项
                element.tabAdd('myTabs', {
                    title: title //用于演示
                    , content: '<iframe style="width:100%;height:100%;position:relative;" src="'+url+'" frameborder="0" scrolling="true" ></iframe>'
                    ,id:id
                })
            },tabChange: function(id){
                //切换到指定Tab项
                element.tabChange('myTabs', id); //切换到：用户管理
            }
        };
        $(".side-nav-class").on("click",function () {
            var data_id = $(this).attr("data-id");
            var data_url = $(this).attr("data-url");
            var data_title = $(this).attr("data-title");
            if($(".layui-tab-title li[lay-id]").length <= 0){
                //增加选择卡
                //新增一个Tab项
                //tabAdd("容器的 lay-filter ")
                //新增一个Tab项
                active.tabAdd(data_title,data_url,data_id);
            }else{
                //判断是否重复
                var flag = false;//没有重复
                $(".layui-tab-title li[lay-id]").each(function(json){
                    if($(this).attr("lay-id") == data_id){
                        flag = true;
                    }
                })
                if(flag == false){
                    active.tabAdd(data_title,data_url,data_id);
                }
            }
            //切换到指定Tab项
            active.tabChange(data_id);
        })
    });
</script>
</body>
</html>