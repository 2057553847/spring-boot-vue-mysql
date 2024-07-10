package com.springboot.service;



import com.github.pagehelper.PageInfo;
import com.springboot.entity.Log;
import com.springboot.entity.Params;
import com.springboot.entity.Role;

import java.util.List;

public interface LogService {

    void add(Log log);

    void delete(Integer id);

    PageInfo<Log> pageSelect(Params params);
}
