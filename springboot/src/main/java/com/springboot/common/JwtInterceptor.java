package com.springboot.common;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.springboot.entity.Admin;
import com.springboot.exception.CustomException;
import com.springboot.service.AdminService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * jwt拦截器
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {
    private static final Logger log = LoggerFactory.getLogger(JwtInterceptor.class);

    @Resource
    private AdminService adminService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler){
        // 从http请求的header获取token
        String token = request.getHeader("token");
        if (StrUtil.isBlank(token)){
            // 如果没拿到再去参数那里拿
            token = request.getParameter("token");
        }
        // 开始执行认证
        if (StrUtil.isBlank(token)){
            throw new CustomException("无token，请重新登录");
        }
        // 获取 token里的adminId
        String adminId;
        Admin admin;
        try {
            adminId = JWT.decode(token).getAudience().get(0);
            // 根据token中的adminId查询数据库
            admin = adminService.findById(Integer.parseInt(adminId));
        }catch (Exception e){
            String errMsg = "token验证失败，重新登录";
            log.error(errMsg+",token="+token,e);
            throw new CustomException(errMsg);
        }
        if (admin == null){
            throw new CustomException("用户不存在，重新登陆");
        }
        try {
            // 用户密码加签证 验证token
            JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(admin.getPassword())).build();
            jwtVerifier.verify(token);
        }catch (JWTVerificationException e){
            throw new CustomException("token验证失败，重新登陆");
        }
        log.info("token验证成功");
        return true;
    }
}
