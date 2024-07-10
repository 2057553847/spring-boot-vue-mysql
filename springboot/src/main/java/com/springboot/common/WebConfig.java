package com.springboot.common;

import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Resource
    private JwtInterceptor jwtInterceptor;
    public void configurePathMatch(PathMatchConfigurer configurer){
        configurer.addPathPrefix("/api",clazz -> clazz.isAnnotationPresent(RestController.class));
    }

    // 添加自定义拦截器设置规则
    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(jwtInterceptor).addPathPatterns("/**")
                .excludePathPatterns("/api/admin/export")
                .excludePathPatterns("/api/admin/upload")
                .excludePathPatterns("/api/admin/enroll")
                .excludePathPatterns("/api/admin/login");
    }
}
