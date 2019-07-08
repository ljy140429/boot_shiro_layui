package com.by.realm;

import com.by.model.User;
import com.by.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.util.Set;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String userName = (String)principals.getPrimaryPrincipal();

        Set<String> roles = userService.findRole(userName);

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);

        Set<String> Permissions = userService.findPer(userName);

        info.addStringPermissions(Permissions);

        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken)authenticationToken;
        String username = token.getUsername();
        User user = null;
        if (!StringUtils.isEmpty(username)){
            user = userService.selectByName(username);
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo = null;
        if (user != null){
            String userName = user.getUserName();
            String userPswd = user.getUserPswd();
            String realmName = getName();
            ByteSource bytes = ByteSource.Util.bytes(user.getUserName());
            simpleAuthenticationInfo = new SimpleAuthenticationInfo(userName, userPswd,bytes, realmName);
        }
        return simpleAuthenticationInfo;
    }
}
