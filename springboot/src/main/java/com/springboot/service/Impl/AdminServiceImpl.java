package com.springboot.service.Impl;

import cn.hutool.core.date.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springboot.common.JwtTokenUtils;
import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.entity.Permissions;
import com.springboot.entity.Role;
import com.springboot.exception.CustomException;
import com.springboot.mapper.AdminMapper;
import com.springboot.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper mapper;

    @Override
    public void add(Admin admin) {

        if (admin.getUsername() == null || "".equals(admin.getUsername())) {
            throw new CustomException("用户名不能为空");
        }
        Admin user = mapper.selectAdminByUserName(admin.getUsername());
        if (user != null) {
            throw new CustomException("用户名已经存在，请更换");
        }
        if (admin.getPassword() == null) {
            admin.setPassword("123");
        }
        if (admin.getState() == null || "".equals(admin.getState())) {
            admin.setState("user");
        }
        if (admin.getRoleId() == 0) {
            admin.setRoleId(3);
        }
        admin.setTime(DateUtil.now());
        mapper.add(admin);
    }

    @Override
    public void update(Admin admin) {
        mapper.update(admin);
    }

    @Override
    public void delete(Integer id) {
        mapper.delete(id);
    }

    @Override
    public Admin login(Admin admin) {
        // 非空判断和数据库查询
        if (admin.getUsername() == null || admin.getPassword() == null ||
                admin.getUsername().isEmpty() || admin.getPassword().isEmpty()) {
            throw new CustomException("用户名和密码不能为空");
        }

        Admin admins = mapper.AdminByPassword(admin.getUsername(), admin.getPassword());

        // 数据库查询结果处理
        if (admins == null) {
            throw new CustomException("用户名或密码错误");
        } else if (admins.getRoleId() == 0) {
            throw new CustomException("用户角色不存在，请联系管理员");
        }
        Role role = mapper.findByRoleId(admins.getRoleId());
        if (role.getPermissionsId() == 0) {
            throw new CustomException("用户权限不存在，请联系管理员");
        }
        Permissions permissions = mapper.findBySate(role.getPermissionsId());
        if(permissions.getState().equals("")){
            throw new CustomException("用户权限已禁用，请联系管理员");
        }
        // 查出来了都对
        // 生成用户对应的token
        String token = JwtTokenUtils.genToken(String.valueOf(admins.getId()), admins.getPassword());
        admins.setToken(token);
        return admins;
    }

    @Override
    public Admin findById(Integer id) {
        return mapper.selectByKey(id);
    }

    @Override
    public List<Admin> findAll() {
        return mapper.findAll();
    }

    @Override
    public PageInfo<Admin> pageSelect(Params params) {
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Admin> list = mapper.pageSelect(params);
        return PageInfo.of(list);
    }

    @Override
    public List<String> findAllUsernames() {
        return mapper.findAllUsernames();
    }
}
