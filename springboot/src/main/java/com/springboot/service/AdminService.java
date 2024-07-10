package com.springboot.service;

import com.github.pagehelper.PageInfo;
import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.entity.Role;

import java.util.List;

public interface AdminService {
    void add(Admin admin);

    void update(Admin admin);

    void delete(Integer id);

    Admin login(Admin admin);

    Admin findById(Integer id);
    List<Admin> findAll();
    PageInfo<Admin> pageSelect(Params params);

    List<String> findAllUsernames();
}
