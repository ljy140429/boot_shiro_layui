package com.by.service.impl;

import com.by.mapper.JueMapper;
import com.by.mapper.UserMapper;
import com.by.model.Jue;
import com.by.model.User;
import com.by.model.UserRolesVo;
import com.by.vo.UserVO;
import com.by.service.UserService;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private JueMapper jueMapper;

    @Autowired
    private UserMapper userMapper;

    @Transactional
    @Override
    public List<User> selectAll() {
        return userMapper.selectAll();
    }

    @Transactional
    @Override
    public void addUser(User user) {

        userMapper.addUser(user);
    }

    @Transactional
    @Override
    public void deleteUser(Integer userId) {
        userMapper.deleteUser(userId);
    }

    @Transactional
    @Override
    public User selectById(Integer userId) {
        return userMapper.selectById(userId);
    }

    @Transactional
    @Override
    public void updUser(User user) {
        userMapper.updUser(user);
    }

    @Transactional
    @Override
    public Integer userJue(Integer userId) {
        return userMapper.userJue(userId);
    }

    @Override
    public Map<String, Object> selectAllS(Integer userId) {
        Map<String, Object> map = new HashMap<>();
        List<Jue> roles = jueMapper.selectAll();
        List<Integer> roleIds = userMapper.selectUserRole(userId);
        map.put("roles",roles);
        map.put("roleIds",roleIds);
        return map;
    }

    @Transactional
    @Override
    public void userRole(UserRolesVo userRoleVo) {
        userMapper.deleteUserRoleByUserId(userRoleVo.getUserId());

        //添加数据
        if (userRoleVo.getRoles() != null) {
            userMapper.insertUserRole(userRoleVo);
        }
    }

    @Override
    public List<UserVO> selectAll2(Map<String, Object> pagemap) {
        return userMapper.selectAll2(pagemap);
    }

    @Override
    public Integer selectAllSize() {
        return userMapper.selectAllSize();
    }

    @Override
    public User selectByName(String username) {
        return userMapper.selectByName(username);
    }

    @Override
    public Set<String> findRole(String userName) {
        return userMapper.findRole(userName);
    }

    @Override
    public Set<String> findPer(String userName) {
        return userMapper.findPer(userName);
    }

    @Transactional
    @Override
    public Boolean addUser2(User user) {
        User user1 = userMapper.selectByName(user.getUserName());
        if (user1 == null){
            userMapper.addUser(user);
            return true;
        }else{
           return false;
        }
    }
}
