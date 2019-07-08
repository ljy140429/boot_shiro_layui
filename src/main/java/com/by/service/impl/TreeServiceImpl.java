package com.by.service.impl;

import com.by.mapper.TreeMapper;
import com.by.service.JueService;
import com.by.service.TreeService;
import com.by.vo.TreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sun.reflect.generics.tree.Tree;

import java.util.List;

@Service
public class TreeServiceImpl implements TreeService {
    @Autowired
    private TreeMapper treeMapper;

    @Transactional
    @Override
    public List<Tree> FindAllByPid(Integer pid) {
        return treeMapper.FindAllByPid(pid);
    }

    @Transactional
    @Override
    public List<TreeVO> FindAll() {
        int pid = 0;
        List<TreeVO> list = treeMapper.FindAllByPid2(pid);
        getTree(list);
        return list;
    }


    public  void getTree(List<TreeVO> trees){
        for (int i = 0; i < trees.size(); i++){
            TreeVO tree2 = trees.get(i);
            Integer pid2 = tree2.getId();
            List<TreeVO> trees3 = treeMapper.FindAllByPid2(pid2);
            tree2.setChildren(trees3);
            getTree(trees3);
        }
    }
}
