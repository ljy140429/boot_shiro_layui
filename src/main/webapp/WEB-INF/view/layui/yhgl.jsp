<%--  Created by IntelliJ IDEA.  
User: Lenovo  
Date: 2019/7/2  
Time: 9:01 
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
</head>
<body>
<table class="layui-hide" id="test" lay-filter="userTableFilter"></table>
<div style="display: none" id="addDiv">
<form class="layui-form" action="">
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
            <button class="layui-btn" lay-submit lay-filter="addSubmit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</div>
<div style="display: none;" id="role">
    <form class="layui-form" action="">

        <input type="hidden" name="userId" id="userId">
        <div class="layui-form-item">
            <label class="layui-form-label">角色：</label>
            <div class="layui-input-block" id="rolesId">

            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="roleSubmit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<script>
    layui.use(['table','layer','form','jquery'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;
        var form = layui.form;
        var active = {
            "showRoleByUserId":function(userId){

                //查询到全部的 role，显示出来
                //获取到当前用户的 role_id 选中
                //{'roles':list<Role> ,'roleIds':1,3}
                $.get("/user/roles",{'userId':userId},function (data) {

                    var roles = data.roles;
                    var roleIds = data.roleIds;

                    $("#rolesId").empty();//清除当前元素中的对象

                    for(var i = 0;i<roles.length;i++){
                        var che = '';
                        //数组.indexOf(xxx)，判断数组中有没有xxx对象，如果没有是-1
                        if(roleIds.indexOf(roles[i].roleId)>-1){//有重复的内容，则应该被选中
                            che = 'checked';
                        }
                        $("#rolesId").append('<input type="checkbox" '+che+' name="roles['+i+']" value="'+roles[i].roleId+'" title="'+roles[i].roleName+'"><br>');
                    }
                    form.render(); //更新全部
                },'json');
            }
        }
        table.render({
            elem: '#test'
            ,height:'full-60'
            ,url:'/user/selectAll2'
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,page:true
            ,toolbar:'#tableToolBar'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}//复选框
                ,{field:'userId',title: 'id',sort: true, fixed: 'left'}
                ,{field:'userName',title: '用户名'}
                ,{field:'roles',title: '用户角色'
                    ,templet: function(d){
                        var roles = d.roles;
                        var  str = '';
                        for (var i = 0; i < roles.length; i++) {
                            str += ','+roles[i].roleName;
                        }
                        str = str.substring(1);
                        return str;
                    }
                }
                ,{fixed: 'right', title:'操作', toolbar: '#userToolBar', width:150}
            ]]
        });
        table.on('tool(userTableFilter)',function (obj) {
            var data =obj.data;
            var layEvent = obj.event;
            var tr= obj.tr;
            if (layEvent == 'del'){
                layer.confirm('真的删除吗',function(index) {
                    $.post('/user/deleteUser/'+data.userId,{'_method':'delete'},function(data) {
                        if (data == 'success'){
                            obj.del();
                            table.reload("test", {page:{curr:1}});
                        }else{
                            layer.msg('删除失败！');
                        }
                    },'text');
                    layer.close(index);
                })
            }else if (layEvent == 'edit'){
                var userId = data.userId;
                $("#userId").val(userId);
                active.showRoleByUserId(userId);
                layer.open({
                    type: 1,
                    title:'赋角色',
                    area: ['500px', '300px'],
                    content: $('#role'), //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                });
            }
        });
        form.on('submit(roleSubmit)', function(data){
            //ajax赋角色
            $.post("/user/userRole",data.field,function(data){
                if(data.success){
                     table.reload("test", {page:{curr:1}});//从第一页加载
                }else{
                    layer.msg('失败！');
                }
                layer.closeAll();
            },"json")

            return false;//防止表单自动提交
        });
        form.on('submit(addSubmit)', function(data){
            //ajax赋角色
            $.post("/user/addUser",data.field,function(data){
                if(data.success){
                    table.reload("test", {page:{curr:1}});//从第一页加载
                }else{
                    layer.msg('失败！');
                }
                layer.closeAll();
            },"json")

            return false;//防止表单自动提交
        });
        table.on('toolbar(userTableFilter)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        content: $('#addDiv') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                    });
                    break;
            };
        });
    });
    function xxx() {
        layer.open({
            title:'二维码',
            type: 1,
            content: $('#jiaz') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
        });
    }
</script>

<script type="text/html" id="userToolBar">
    <s:hasRole name="vipuser">
    <a class="layui-btn layui-btn-xs" lay-event="edit">赋角色</a>
    </s:hasRole>
    <s:hasRole name="supervipuser">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </s:hasRole>
</script>
<script type="text/html" id="tableToolBar">
    <s:hasRole name="user">
    <a class="layui-btn layui-btn-xs" lay-event="add">增加</a>
    </s:hasRole>
    <s:hasRole name="user">
        暂无权限:请联系管理员<a href="javascript:xxx()"><font color="red">购买</font></a>
    </s:hasRole>
</script>
<div style="display: none" id="jiaz">
    <font>扫码支付</font>
    <font color="#cd853f">假装有个二维码</font>
    <img src="" width="100px" height="100px">
</div>
</body>
</html>