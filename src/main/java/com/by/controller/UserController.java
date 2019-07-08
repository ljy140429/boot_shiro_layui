package com.by.controller;

import com.by.model.User;
import com.by.model.UserRolesVo;
import com.by.vo.UserVO;
import com.by.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

//登陆
    @RequestMapping("login")
    public ModelAndView login(User user){

        Subject subject = SecurityUtils.getSubject();
        ModelAndView mv = new ModelAndView();
        String msg = "";
        if (!subject.isAuthenticated()){
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), user.getUserPswd());
            try {
                subject.login(token);
            } catch (UnknownAccountException e) {
                msg = "登陆失败:账号不存在";
            } catch (IncorrectCredentialsException e){
                msg = "密码错误";
            } catch (AuthenticationException e){
                msg = "登陆失败";
            }
        }
        if (!"".equals(msg)){
            mv.addObject("msg",msg);
            mv.setViewName("forward:/login.jsp");
        }else {
            mv.setViewName("redirect:/test.jsp");
        }
        return mv;
    }

//查询全部
//    @ResponseBody
//    @RequestMapping("selectAll")
//    public List<User> selectAll(){
//        List<User> users = userService.selectAll();
//        return users;
//    }

    @ResponseBody
    @GetMapping("selectAll2")
    public Map<String,Object> selectAll2(Integer page,Integer limit){
        Map<String, Object> pagemap = new HashMap<>();
        pagemap.put("start",(page - 1) * limit);
        pagemap.put("limit",limit);
        List<UserVO> users = userService.selectAll2(pagemap);
        Map<String, Object> map = new HashMap<>();
        map.put("code","0");
        map.put("msg","");
        map.put("count",userService.selectAllSize());
        map.put("data",users);
        return map;
    }

//增加
    @ResponseBody
    @PostMapping("addUser")
    public Map<String, Object> addUser(User user){
        Map<String, Object> map = new HashMap<>();
        SimpleHash md5 = new SimpleHash("MD5", user.getUserPswd(), user.getUserName(), 3);
        user.setUserPswd(md5.toString());
        try {
            userService.addUser(user);
            map.put("success",true);
            return map;
        } catch (Exception e) {
            e.printStackTrace();
        }
        map.put("success",false);
        return map;
    }

//删除
    @RequiresRoles({"vipuser"})
    @ResponseBody
    @DeleteMapping("deleteUser/{id}")
    public String deleteUser(@PathVariable("id")Integer userId){
        try {
            userService.deleteUser(userId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

//回显
    @RequiresRoles({"vipuser"})
    @ResponseBody
    @GetMapping("update/{id}")
    public User update(@PathVariable("id")Integer userId){
        User u = userService.selectById(userId);
        return u;
    }

//修改
    @RequiresRoles({"vipuser"})
    @ResponseBody
    @PutMapping("updUser")
    public String updUser(User user){
        try {
            userService.updUser(user);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @RequiresRoles({"user"})
    @ResponseBody
    @RequestMapping("userJue/{id}")
    public Integer userJue(@PathVariable("id")Integer userId){
        Integer roleId = userService.userJue(userId);
        return roleId;
    }

    @RequiresRoles({"user"})
    @ResponseBody
    @GetMapping("roles")
    public Map<String,Object> roles(Integer userId){
        Map<String, Object> map = new HashMap<>();
        map = userService.selectAllS(userId);
        return map;
    }

    @RequiresRoles({"supervipuser"})
    @ResponseBody
    @PostMapping("userRole")
    public Map<String ,Object>  userRole(UserRolesVo userRoleVo){
        Map<String,Object> map = new HashMap<>();
        try {
            userService.userRole(userRoleVo);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    @PostMapping("zhuCe")
    public ModelAndView zhuCe(User user){
        SimpleHash md5 = new SimpleHash("MD5", user.getUserPswd(), user.getUserName(), 3);
        user.setUserPswd(md5.toString());
        ModelAndView m = new ModelAndView();
        Boolean b = userService.addUser2(user);
            if (!b){
            m.addObject("msg","注册失败");
            m.setViewName("forward:/register.jsp");
        }else {
                m.addObject("msg", "注册成功");
                m.setViewName("forward:/login.jsp");
            }
            return m;
    }
}
