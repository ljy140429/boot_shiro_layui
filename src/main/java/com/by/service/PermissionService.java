package com.by.service;

import com.by.model.JuePer;
import com.by.model.Permission;

import java.util.List;
import java.util.Map;

public interface PermissionService {

    List<Permission> selectAll();

    void addper(Permission per);

    void delete(Integer perId);

    Permission updper(Integer perId);

    void update(Permission per);

    Map<String, Object> selectJuePer(Integer roleId);

    void upd(JuePer juePer);
}
