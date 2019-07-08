package com.by.controller;

import com.by.service.TreeService;
import com.by.vo.TreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.reflect.generics.tree.Tree;

import java.util.List;

@Controller
@RequestMapping("tree")
public class TreeController {

    @Autowired
    private TreeService treeService;

    @ResponseBody
    @RequestMapping("tree")
    public List<Tree> tree(@RequestParam(defaultValue = "0",required = false)
                                   Integer id){
        List<Tree> list = treeService.FindAllByPid(id);
        return list;
    }

    @ResponseBody
    @RequestMapping("trees")
    public List<TreeVO> trees(){
        List<TreeVO> list = treeService.FindAll();
        return list;
    }
}
