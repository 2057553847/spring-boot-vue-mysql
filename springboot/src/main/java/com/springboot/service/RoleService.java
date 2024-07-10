package com.springboot.service;



import com.github.pagehelper.PageInfo;
import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.entity.Role;

import java.util.List;

public interface RoleService {

    void add(Role role);

    void update(Role role);

    void delete(Integer id);

    List<Role> findAll();

    PageInfo<Role> pageSelect(Params params);
}
