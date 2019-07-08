package com.by.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserJueVo {

    private Integer userId;
    private String userName;
    private String userPswd;
    private Integer urId;
    private Integer roleId;
    private String roleName;
}
