package com.springboot.service;

import com.github.pagehelper.PageInfo;
import com.springboot.entity.Params;
import com.springboot.entity.Permissions;

import java.util.List;

public interface PermissionsService {
    void add(Permissions permissions);

    void update(Permissions permissions);

    void delete(Integer id);

    List<Permissions> findAll();

    PageInfo<Permissions> pageSelect(Params params);
}
