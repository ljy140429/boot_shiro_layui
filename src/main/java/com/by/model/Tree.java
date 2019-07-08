package com.by.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tree {

    private Integer id;
    private String text;
    private String iconCls;
    private String checked;
    private String state;
    private String url;
    private Integer PId;
}
