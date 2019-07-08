package com.by.service.impl;

import com.by.mapper.PermissionMapper;
import com.by.model.JuePer;
import com.by.model.Permission;
import com.by.service.JueService;
import com.by.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Transactional
    @Override
    public List<Permission> selectAll() {
        return permissionMapper.selectAll();
    }

    @Transactional
    @Override
    public void addper(Permission per) {
        permissionMapper.addper(per);
    }

    @Transactional
    @Override
    public void delete(Integer perId) {
        permissionMapper.delete(perId);
    }

    @Transactional
    @Override
    public Permission updper(Integer perId) {
        return permissionMapper.updper(perId);
    }

    @Transactional
    @Override
    public void update(Permission per) {
        permissionMapper.update(per);
    }

    @Override
    public Map<String, Object> selectJuePer(Integer roleId) {
        Map<String, Object> map = new HashMap<>();
        List<Permission> perall = permissionMapper.selectAll();
        List<Integer> jueIds = permissionMapper.selectjp(roleId);
        map.put("perall",perall);
        map.put("jueIds",jueIds);
        return map;
    }

    @Transactional
    @Override
    public void upd(JuePer juePer) {
        permissionMapper.deljp(juePer.getRoleId());
        if (juePer.getPers() != null){
            permissionMapper.insert(juePer);
        }
    }
}
