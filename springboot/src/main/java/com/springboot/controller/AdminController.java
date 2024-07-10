package com.springboot.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.github.pagehelper.PageInfo;
import com.springboot.common.AutoLog;
import com.springboot.common.Result;
import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.exception.CustomException;
import com.springboot.service.AdminService;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/admin")
public class AdminController {
    private static final Logger logs = LoggerFactory.getLogger(AdminController.class);

    @Resource
    private AdminService service;

    @GetMapping("/pageSelect")
    public Result findBySearch(Params params) {
        logs.info("拦截器已放行，正式调用接口内部，查询信息");
        PageInfo<Admin> info = service.pageSelect(params);
        return Result.success(info);
    }

    @GetMapping
    public Result findAll() {
        List<Admin> list = service.findAll();
        return Result.success(list);
    }

    @PutMapping("/delBatch")
    @AutoLog("批量删除用户数据")
    public Result delBatch(@RequestBody List<Admin> list) {
        for (Admin admin : list) {
            service.delete(admin.getId());
        }
        return Result.success();
    }

    @PostMapping("/login")
    @AutoLog("登录用户系统")
    public Result login(@RequestBody Admin admin) {
        Admin LoginUser = service.login(admin);
        return Result.success(LoginUser);
    }

    @PostMapping
    @AutoLog("更新用户数据")
    public Result add(@RequestBody Admin admin) {
        if (admin.getId() == 0) {
            service.add(admin);
        } else {
            service.update(admin);

        }
        return Result.success();
    }

    @DeleteMapping("/{id}")
    @AutoLog("删除用户数据")
    public Result delete(@PathVariable Integer id) {
        service.delete(id);
        return Result.success();
    }

    @PostMapping("/enroll")
    public Result enroll(@RequestBody Admin admin) {
        service.add(admin);
        return Result.success();
    }

    @GetMapping("/export")
    public Result export(HttpServletResponse response) throws IOException {
        // 组装每一行数据，放到list里面
        //每一行数据对应数据库的数据
        //映射数据 Map<key,value>

        // 查询出数据库所有数据
        List<Admin> all = service.findAll();
        if (CollectionUtil.isEmpty(all)) {
            throw new CustomException("没有数据");
        }
        //定义一个Map<key,value>
        List<Map<String, Object>> list = new ArrayList<>(all.size());
        //遍历每一条数据，封装到Map<key,value>里，把map放入list
        for (Admin admin : all) {
            if (!admin.getUsername().equals("root")) {
                Map<String, Object> row = new HashMap<>();
                row.put("用户名", admin.getUsername());
                row.put("姓名", admin.getName());
                row.put("注册时间", admin.getTime());
                row.put("权限状态", admin.getState());
                row.put("角色分类", admin.getRoleId());

                list.add(row);
            }
        }
        //创建ExcelWriter对象，把list写入到Excel文件里
        ExcelWriter excelWriter = ExcelUtil.getWriter(true);
        excelWriter.write(list, true);
        // 把这个excel下载出来
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=admin.xlsx");
        ServletOutputStream out = response.getOutputStream();
        excelWriter.flush(out, true);
        excelWriter.close();
        IoUtil.close(System.out);
        return Result.success();
    }

    @PostMapping("/upload")
    public Result upload(MultipartFile file) throws IOException {
        List<Admin> infoList = ExcelUtil.getReader(file.getInputStream()).readAll(Admin.class);
        if (!CollectionUtil.isEmpty(infoList)) {
            List<String> usernames = new ArrayList<>();
            for (Admin admin : infoList) {
                usernames.add(admin.getUsername());
            }

            List<String> existingUsernames = service.findAllUsernames();
            for (String username : usernames) {
                if (existingUsernames.contains(username)) {
                    throw new CustomException("用户名已存在: " + username);
                }
            }
            for (Admin admin : infoList) {
                try {
                    service.add(admin);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return Result.success();
    }

}
