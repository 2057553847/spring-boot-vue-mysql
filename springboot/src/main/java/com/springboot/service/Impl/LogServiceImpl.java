package com.springboot.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springboot.entity.Log;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import com.springboot.exception.CustomException;
import com.springboot.mapper.LogMapper;
import com.springboot.mapper.RoleMapper;
import com.springboot.service.LogService;
import com.springboot.service.RoleService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogServiceImpl implements LogService {
    @Resource
    private LogMapper mapper;

    @Override
    public void add(Log log) {mapper.add(log);}

    @Override
    public void delete(Integer id) {
        mapper.delete(id);
    }

    @Override
    public PageInfo<Log> pageSelect(Params params) {
        // 开启分页
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Log> list = mapper.pageSelect(params);
        return PageInfo.of(list);
    }
}
