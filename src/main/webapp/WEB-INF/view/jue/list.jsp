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
                url:'/jue/selectAll',
                fitColumns:true,
                columns:[[
                    {field:'ck',align:'center',width:50,checkbox:true},
                    {field:'roleId',title:'角色编号',width:100},
                    {field:'roleName',title:'角色姓名',width:100},
                ]],
                toolbar: [{
                    iconCls: 'icon-add',
                    title:'增加',
                    handler: function(){addUser('addDiv','增加角色')}
                },'-',{
                    iconCls: 'icon-cancel',
                    title:'删除',
                    handler: function(){deleteId()}
                },'-',{
                    iconCls: 'icon-edit',
                    title:'修改',
                    handler: function(){update()}
                },'-',{
                    title:'赋权限',
                    text:'赋权限',
                    handler: function(){
                        setper();
                    }
                },'-',{
                    iconCls: 'icon-help',
                    title:'帮助',
                    handler: function(){alert('暂无此功能')}
                }]
            })
        });

        function setper() {
            var jue = $('#tab').datagrid('getSelected');
                $("#roleId").val(jue.roleId);
                addUser('setDiv','赋权限')
                $("#perId").empty();
            $.get('/per/selectJuePer/'+jue.roleId,function (data) {
                    var per = data.perall;
                    var jueIds = data.jueIds;
                for (var i = 0; i < per.length; i++) {
                    var che = '';
                    //数组.indexOf(xxx)，判断数组中有没有xxx对象，如果没有是-1
                    if(jueIds.indexOf(per[i].perId)>-1){//有重复的内容，则应该被选中
                        che = 'checked';
                    }
                    $("#perId").append('<input type="checkbox" '+che+' name="pers['+i+']" value="'+per[i].perId+'">'+per[i].perName+'</input>');
                }
            },'json');
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
            var jue = $('#tab').datagrid('getSelected');
            if(jue == null){
                alert("请选择需要删除的数据！");
                return ;
            }
            $.messager.confirm('确认','确定要删除['+jue.roleName+']吗？',function(r){
                if (r){
                    var id = jue.roleId;
                    $.ajax({
                        url:'/jue/delete/'+id,
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
            var jue = $('#tab').datagrid('getSelected');
            if (null == jue){
                return;
            }
            var roleId = jue.roleId;
            $('#updFrom').form('load','/jue/updjue/'+roleId);
            addUser('updDiv','修改角色');
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
<table id="tab"></table>
<%--增加--%>
<div id="addDiv" style="display: none;">
    <form id="addFrom" method="post">
        <table cellpadding="5">
            <tr>
            <tr>
                <td>角色：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="roleName" data-options="required:true"></input>
                </td>
            </tr>
            <tr>

        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updForm('addFrom','addDiv','jue/addjue')">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div>

<%--修改--%>
<div id="updDiv" style="display: none;">
    <form id="updFrom" method="post">
        <input type="hidden" name="_method" value="put">
        <input type="hidden" name="roleId">
        <table cellpadding="5">
            <tr>
            <tr>
                <td>角色：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="roleName" data-options="required:true"></input>
                </td>
            </tr>
            <tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updForm('updFrom','updDiv','jue/update')">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div>
<div id="setDiv" style="display: none;">
    <form id="setFrom" method="post">
        <input type="hidden" name="roleId" id="roleId">
        <table cellpadding="5">
            <tr>
            <tr>
                <td>权限：</td>
                <td>
                    <div class="layui-input-block" id="perId">

                    </div>
                </td>
            </tr>
            <tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updForm('setFrom','setDiv','/per/upd')">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div>
</body>
</html>