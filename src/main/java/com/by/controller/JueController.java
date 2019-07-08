package com.by.controller;

import com.by.model.Jue;
import com.by.service.JueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("jue")
public class JueController {

    @Autowired
    private JueService jueService;

    @ResponseBody
    @RequestMapping("selectAll")
    public List<Jue> selectAll(){
        List<Jue> jues = jueService.selectAll();
        return jues;
    }

    @ResponseBody
    @RequestMapping("addjue")
    public String addjue(Jue jue){
        try {
            jueService.addjue(jue);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @ResponseBody
    @DeleteMapping("delete/{id}")
    public String delete(@PathVariable("id")Integer roleId){
        try {
            jueService.delete(roleId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    @ResponseBody
    @RequestMapping("updjue/{id}")
    public Jue updjue(@PathVariable("id")Integer roleId){
        Jue jue = jueService.selectById(roleId);
        return jue;
    }

    @ResponseBody
    @PutMapping("update")
    public String update(Jue jue){
        try {
            jueService.update(jue);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

}
