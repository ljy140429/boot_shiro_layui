package com.by.model;

import lombok.Data;

import java.util.List;

@Data
public class UserRolesVo {

    private Integer userId;
    private List<Integer> Roles;
}
