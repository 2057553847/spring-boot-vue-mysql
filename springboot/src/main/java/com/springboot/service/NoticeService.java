package com.springboot.service;

import com.github.pagehelper.PageInfo;
import com.springboot.entity.Notice;
import com.springboot.entity.Params;

import java.util.List;

public interface NoticeService {
    void add(Notice notice);
    PageInfo<Notice> pageSelect(Params params);

    void update(Notice notice);

    void delete(Integer id);

    List<Notice> selectAll();
}
