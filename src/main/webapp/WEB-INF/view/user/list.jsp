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
        $(function () {
            $('#tab').datagrid({
                url:'/user/selectAll',
                fitColumns:true,
                columns:[[
                    {field:'ck',align:'center',width:50,checkbox:true},
                    {field:'userId',title:'用户编号',width:100},
                    {field:'userName',title:'用户姓名',width:100},
                ]],
                toolbar: [{
                    iconCls: 'icon-add',
                    title:'增加',
                    handler: function(){addUser('addDiv','增加用户')}
                },'-',{
                    iconCls: 'icon-cancel',
                    title:'删除',
                    handler: function(){deleteId()}
                },'-',{
                    iconCls: 'icon-edit',
                    title:'修改',
                    handler: function(){update()}
                },'-',{
                    iconCls: 'icon-tip',
                    title:'角色管理',
                    text:'角色管理',
                    handler: function(){
                        addUser('jueDiv','角色');jue()
                    }
                },'-',{
                    iconCls: 'icon-help',
                    title:'帮助',
                    handler: function(){alert('暂无此功能')}
                }]
            })
        });

        function jue() {
            var user = $('#tab').datagrid('getSelected');
            if(user == null){
                return ;
            };
            var userId = user.userId;
            $.ajax({
                url:'user/userJue'+userId,
                type:'get',
                success:function (data) {

                },error:function () {
                    alert('错误');
                }
            })

        }
        //增加
        function addUser(id,tit){
            $('#'+id).dialog({
                title: tit,
                width: 400,
                height: 300,
                closed: false,
                cache: false,
                modal: true
            });
        }


        function clearForm(){
            $('#addFrom').form('clear');
        }

        function deleteId(){
            // 返回第一个被选中的行或如果没有选中的行则返回null。
            var user = $('#tab').datagrid('getSelected');
            if(user == null){
                alert("请选择需要删除的数据！");
                return ;
            }
            $.messager.confirm('确认','确定要删除['+user.userName+']吗？',function(r){
                if (r){
                    var id = user.userId;
                    $.ajax({
                        url:'/user/deleteUser/'+id,
                        type:'delete',
                        success:function(data){
                            if(data == "success"){
                                $.messager.alert('提示','删除成功');
                            }else{
                                $.messager.alert('提示',"删除失败")
                            }
                            $('#tab').datagrid('reload');
                        }
                    })
                }
            });
        }
        function  update() {
            var user = $('#tab').datagrid('getSelected');
            if (null == user){
                return;
            }
            var userId = user.userId;
            $('#updFrom').form('load','/user/update/'+userId);
            addUser('updDiv','修改用户');
        }
        function  updForm(formId,divId,url){
            $.messager.progress();
            $('#'+formId).form('submit', {
                url: url,
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){
                        $.messager.progress('close');
                    }
                    return isValid;
                },
                success: function(data){
                    if(data == 'success'){
                        $('#'+divId).dialog('close');
                        $('#tab').datagrid('reload');
                        $('#'+formId).form('reset');
                    }
                    $.messager.progress('close');
                }
            });
        }

    </script>
</head>
<body>
<div id="jueDiv" style="display: none;">
    <form>
        角色:<input id="cc" name="roleId">
        <input type="submit" value="提交">
    </form>
</div>
<table id="tab"></table>
<%--增加--%>
<div id="addDiv" style="display: none;">
    <form id="addFrom" method="post">
        <table cellpadding="5">
            <tr>
                <td>用户姓名：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input>
                </td>
            </tr>
            <tr>

            <tr>
                <td>用户密码：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="userPswd" data-options="required:true"></input>
                </td>
            </tr>
            <tr>

        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updForm('addFrom','addDiv','user/addUser')">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div>

<%--修改--%>
<div id="updDiv" style="display: none;">
    <form id="updFrom" method="post">
        <input type="hidden" name="_method" value="put">
        <input type="hidden" name="userId">
        <table cellpadding="5">
            <tr>
                <td>用户姓名：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input>
                </td>
            </tr>
            <tr>

            <tr>
                <td>用户密码：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="userPswd" data-options="required:true"></input>
                </td>
            </tr>
            <tr>

        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updForm('updFrom','updDiv','user/updUser')">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div>

</body>
</html>