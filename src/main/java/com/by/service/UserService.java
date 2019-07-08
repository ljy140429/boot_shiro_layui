package com.by.service;

import com.by.model.User;
import com.by.model.UserRolesVo;
import com.by.vo.UserVO;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserService {

    List<User> selectAll();

    void addUser(User user);

    void deleteUser(Integer userId);

    User selectById(Integer userId);

    void updUser(User user);

    Integer userJue(Integer userId);

    Map<String, Object> selectAllS(Integer userId);

    void userRole(UserRolesVo userRoleVo);

    List<UserVO> selectAll2(Map<String, Object> pagemap);

    Integer selectAllSize();

    User selectByName(String username);

    Set<String> findRole(String userName);

    Set<String> findPer(String userName);

    Boolean addUser2(User user);
}
