package com.springboot.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import com.springboot.exception.CustomException;
import com.springboot.mapper.AdminMapper;
import com.springboot.mapper.RoleMapper;
import com.springboot.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper mapper;
    private AdminMapper adminMapper;

    @Override
    public void add(Role role) {
        if (role.getName() == null || "".equals(role.getName())){
            throw new CustomException("角色名称不能为空");
        }
        if (role.getPermissionsId() == 0 ){
            throw new CustomException("选择你拥有的权限");
        }
        if (role.getCode() == null){
            role.setCode("user");
        }
        mapper.add(role);
    }
    @Override
    public void update(Role role) {
        mapper.update(role);
    }

    @Override
    public void delete(Integer id) {mapper.delete(id);}

    @Override
    public List<Role> findAll() {
        return mapper.findAll();
    }

    @Override
    public PageInfo<Role> pageSelect(Params params) {
        // 开启分页
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Role> list = mapper.pageSelect(params);
        return PageInfo.of(list);
    }
}
