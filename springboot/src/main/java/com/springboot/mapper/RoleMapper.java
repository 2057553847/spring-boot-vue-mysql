package com.springboot.mapper;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface RoleMapper {
    void add(Role role);
    void update(Role role);
    void delete(Integer id);
    List<Role> findAll();
    List<Role> pageSelect(@Param("params")Params params);
}
