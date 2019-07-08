package com.by.service.impl;

import com.by.mapper.JueMapper;
import com.by.model.Jue;
import com.by.service.JueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class JueServiceImpl implements JueService {

    @Autowired
    private JueMapper jueMapper;

    @Transactional
    @Override
    public List<Jue> selectAll() {
        return jueMapper.selectAll();
    }

    @Transactional
    @Override
    public void addjue(Jue jue) {
        jueMapper.addjue(jue);
    }

    @Transactional
    @Override
    public void delete(Integer roleId) {
        jueMapper.delete(roleId);
    }

    @Transactional
    @Override
    public Jue selectById(Integer roleId) {
        return jueMapper.selectById(roleId);
    }

    @Transactional
    @Override
    public void update(Jue jue) {
        jueMapper.update(jue);
    }
}
