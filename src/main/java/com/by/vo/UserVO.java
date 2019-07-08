package com.by.vo;

import com.by.model.Jue;
import com.by.model.User;
import lombok.Data;

import java.util.List;

@Data
public class UserVO extends User {

    private List<Jue> roles;
}
