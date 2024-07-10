package com.springboot.mapper;

import com.github.pagehelper.PageInfo;
import com.springboot.entity.Notice;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface NoticeMapper {
    void add(Notice notice);
    void update(Notice notice);
    void delete(Integer id);
    List<Notice> selectAll();
    List<Notice> pageSelect(@Param("params")Params params);
}
