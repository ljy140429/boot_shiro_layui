<%--  Created by IntelliJ IDEA.  
User: Lenovo  
Date: 2019/6/15
Time: 9:31
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
    <link rel="stylesheet" type="text/css" href="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/themes/icon.css">
    <script type="text/javascript" src="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/jquery.min.js"></script>
    <script type="text/javascript" src="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/jquery.easyui.min.js"></script>
    <script>
        $(function(){
            $('#tree').tree({
                url:'/tree/trees',
                onClick: function(node){
                    addTabs(node.text,node.url)
                }
            });
        });
        function addTabs(tit,url) {
            var ex = $("#tabs").tabs('exists',tit);
            if (!ex){
                $('#tabs').tabs('add',{
                    title:tit,
                    content:'<iframe style="width:100%;height:100%;position:relative;" src="'+url+'" frameborder="0" scrolling="true" ></iframe>',
                    closable:true,
                    closable:true,
                    tools:[{
                        iconCls:'icon-mini-refresh',
                        handler:function(){
                            alert('refresh');
                        }
                    }]
                });
            } else{
                $("#tabs").tabs('select',tit);
            }
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',title:'用户管理系统',split:true" style="height:100px;">

</div>
<div data-options="region:'west',title:'目录',split:true" style="width:100px;">
    <ul id="tree"></ul>
<%--        Tree--%>
<%--        <ul id="tree" class="easyui-tree">--%>
<%--            <li>--%>
<%--                <span>学生管理系统</span>--%>
<%--                <ul>--%>
<%--                    <li>--%>
<%--                        <ul>--%>
<%--                        <a href="javascript:addTabs('学生管理','/stu/tolist')">学生管理</a>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    Tree--%>
</div>
<div data-options="region:'center',title:'内容',split:true" style="padding:5px;background:#eee;">
    <div id="tabs" class="easyui-tabs" fit="true">

    </div>
</div>
</body>
</html>