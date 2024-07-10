package com.springboot.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springboot.entity.Params;
import com.springboot.entity.Permissions;
import com.springboot.entity.Role;
import com.springboot.exception.CustomException;
import com.springboot.mapper.PermissionsMapper;
import com.springboot.service.PermissionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PermissionsServiceImpl implements PermissionsService {
    @Autowired
    private PermissionsMapper mapper;
    @Override
    public void add(Permissions permissions) {
        if(permissions.getName() == null || "".equals(permissions.getName())){
            throw new CustomException("权限名称不能为空!");
        }
        if(permissions.getRole_prm() == null || "".equals(permissions.getName())){
            throw new CustomException("请选择权限方法！");
        }
        if(permissions.getState() == null || "".equals(permissions.getState())){
            throw new CustomException("状态未启用！");
        }
        mapper.add(permissions);
    }

    @Override
    public void update(Permissions permissions) {
        mapper.update(permissions);
    }

    @Override
    public void delete(Integer id) {
        mapper.delete(id);
    }

    @Override
    public List<Permissions> findAll() {
        return mapper.findAll();
    }
    @Override
    public PageInfo<Permissions> pageSelect(Params params) {
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Permissions> list = mapper.pageSelect(params);
        return PageInfo.of(list);
    }
}
