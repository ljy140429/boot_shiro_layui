package com.by.exception;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class HandlerException {

    @ExceptionHandler(UnauthorizedException.class)
    public ModelAndView excp(Exception ex){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("forward:/unauthorized.jsp");
        mv.addObject("ex",ex);
        return mv;
    }
}
