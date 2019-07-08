package com.by.vo;

import com.by.model.Tree;
import lombok.Data;
import java.util.List;

@Data
public class TreeVO extends Tree {

    private List<TreeVO> children;
}
