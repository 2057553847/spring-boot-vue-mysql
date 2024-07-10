package com.springboot.exception;

import com.springboot.common.Result;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
// 全局异常处理器
@ControllerAdvice(basePackages="com.springboot.controller")
public class GlobalException {
    // 定义一个Logger对象，用于记录日志
    private static  final Logger log = LoggerFactory.getLogger(GlobalException.class);

    // 定义一个方法，用于处理通用异常
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result error(HttpServletRequest request,Exception e){
        // 记录异常信息
        log.error("异常信息：",e);
        // 返回一个错误信息
        return Result.error("系统异常");
    }
    // 定义一个方法，用于处理自定义异常
    @ExceptionHandler(CustomException.class)
    @ResponseBody
    public  Result customError(HttpServletRequest request,CustomException e){
        // 返回自定义的错误信息
        return Result.error(e.getMsg());
    }
}
