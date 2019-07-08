package com.by.mapper;

import com.by.model.JuePer;
import com.by.model.Permission;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface PermissionMapper {

    @Select("select per_id from t_jp where role_id = #{roleId}")
    List<Integer> selectjp(@Param("roleId") Integer roleId);

    List<Permission> selectAll();

    void addper(Permission per);

    void delete(Integer perId);

    Permission updper(Integer perId);

    void update(Permission per);

    @Delete("delete from t_jp where role_id = #{roleId}")
    void deljp(@Param("roleId") Integer roleId);

    void insert(@Param("jp")JuePer juePer);
}
