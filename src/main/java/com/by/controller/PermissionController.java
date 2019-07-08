package com.by.controller;

import com.by.model.JuePer;
import com.by.model.Permission;
import com.by.model.UserRolesVo;
import com.by.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("per")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @ResponseBody
    @RequestMapping("selectAll")
    public List<Permission> selectAll(){
        List<Permission> per = permissionService.selectAll();
        return per;
    }

    @ResponseBody
    @RequestMapping("addper")
    public String addper(Permission per){
        try {
            permissionService.addper(per);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @ResponseBody
    @DeleteMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer perId){
        try {
            permissionService.delete(perId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @ResponseBody
    @RequestMapping("updper/{id}")
    public Permission updper(@PathVariable("id")Integer perId){
         Permission per = permissionService.updper(perId);
         return per;
    }

    @ResponseBody
    @PutMapping("update")
    public String update(Permission per){
        try {
            permissionService.update(per);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @ResponseBody
    @GetMapping("selectJuePer/{id}")
    public Map<String,Object> selectJuePer(@PathVariable("id") Integer roleId){
        Map<String, Object> map = new HashMap<>();
        map = permissionService.selectJuePer(roleId);
        return map;
    }

    @ResponseBody
    @RequestMapping("upd")
    public String upd(JuePer juePer){
        try {
            permissionService.upd(juePer);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }
}
