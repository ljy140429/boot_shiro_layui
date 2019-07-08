package com.by.mapper;

import com.by.vo.TreeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import sun.reflect.generics.tree.Tree;

import java.util.List;

@Mapper
public interface TreeMapper {

    @Select("select * from my_tree where pid = #{pid}")
    List<Tree> FindAllByPid(@Param("pid") Integer id);

    @Select("select * from my_tree where pid = #{pid}")
    List<TreeVO> FindAllByPid2(@Param("pid") int pid);
}
