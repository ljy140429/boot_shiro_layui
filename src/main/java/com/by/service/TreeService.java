package com.by.service;

import com.by.vo.TreeVO;
import sun.reflect.generics.tree.Tree;

import java.util.List;

public interface TreeService {

    List<Tree> FindAllByPid(Integer pid);

    List<TreeVO> FindAll();
}
