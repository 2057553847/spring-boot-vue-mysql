package com.springboot.mapper;

import com.springboot.entity.Params;
import com.springboot.entity.Permissions;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Mapper
@Repository
public interface PermissionsMapper {
    void add(Permissions permissions);
    void update(Permissions permissions);
    void delete(Integer id);
    List<Permissions> findAll();
    List<Permissions> pageSelect(@Param("params") Params params);
}
