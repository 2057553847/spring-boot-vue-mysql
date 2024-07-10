package com.springboot.common;


import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.springboot.entity.Admin;
import com.springboot.entity.Log;
import com.springboot.service.LogService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Component
@Aspect
public class LogAspect {
    // 注入日志服务
    @Resource
    private LogService service;
    // 日志
    private static final Logger log = LoggerFactory.getLogger(LogAspect.class);
    // 执行接口
    @Around("@annotation(autoLog)")
    public Object doAround(ProceedingJoinPoint joinPoint, AutoLog autoLog) throws Throwable {

        // 系统行为,在需要的接口写上对应的内容
        String name = autoLog.value();
        // 执行时间
        String time = DateUtil.now();
        // 用户名
        String username = "";
        Admin admin = JwtTokenUtils.getCurrentAdmin();
        if (ObjectUtil.isNotNull(admin)){
            username = admin.getUsername();
        }
        // 操作人IP
//        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//        String ip = request.getRemoteAddr();
        String ip = "Windows";
        //  执行的接口
        Result result = (Result) joinPoint.proceed();
        Object date = result.getData();
        if (date instanceof Admin){
            Admin admins = (Admin) date;
            username = admins.getUsername();
        }
        // 往日志写记录
        Log log = new Log(null, name, time, username, ip);
        service.add(log);


        return result;
    }
}
