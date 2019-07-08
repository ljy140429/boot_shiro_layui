package com.by.mapper;

import com.by.model.Jue;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface JueMapper {
    List<Jue> selectAll();

    void addjue(Jue jue);

    void delete(Integer roleId);

    Jue selectById(Integer roleId);

    void update(Jue jue);
}
