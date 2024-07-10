package com.springboot.mapper;

import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.entity.Permissions;
import com.springboot.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Mapper
@Repository
public interface AdminMapper {
    void add(Admin admin);
    void update(Admin admin);
    void delete(Integer id);
    Admin selectAdminByUserName(String username);
    Admin AdminByPassword(String username, String password);

    Admin selectByKey(Integer id);
    List<Admin> findAll();
    List<Admin> pageSelect(@Param("params") Params params);
    Role findByRoleId(int roleId);

    Permissions findBySate(int permissionsId);

    List<String> findAllUsernames();
}
