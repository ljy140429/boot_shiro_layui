package com.by.service;

import com.by.model.Jue;

import java.util.List;

public interface JueService {

    List<Jue> selectAll();

    void addjue(Jue jue);

    void delete(Integer roleId);

    Jue selectById(Integer roleId);

    void update(Jue jue);
}
