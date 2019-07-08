package com.by.mapper;

import com.by.model.User;
import com.by.model.UserRolesVo;
import com.by.vo.UserVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Mapper
public interface UserMapper {

    void addUser(User user);

    void deleteUser(Integer userId);

    List<User> selectAll();

    User selectById(Integer userId);

    void updUser(User user);

    Integer userJue(Integer userId);

    @Select("select role_id from t_uj where user_id = #{userId}")
    List<Integer> selectUserRole(@Param("userId") Integer userId);

    @Delete("delete from t_uj where user_id = #{userId}")
    void deleteUserRoleByUserId(@Param("userId") Integer userId);

    void insertUserRole(@Param("urvo")UserRolesVo userRoleVo);

    List<UserVO> selectAll2(Map<String, Object> pagemap);

    Integer selectAllSize();

    User selectByName(@Param("username") String username);

    Set<String> findRole(@Param("userName")String userName);

    Set<String> findPer(@Param("userName")String userName);
}
