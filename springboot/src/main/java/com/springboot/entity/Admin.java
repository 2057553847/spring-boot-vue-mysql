package com.springboot.entity;

import cn.hutool.core.annotation.Alias;
import lombok.Data;


import javax.persistence.Transient;

@Data
public class Admin {
    private int id;
    @Alias("用户名")
    private String username;
    @Alias("姓名")
    private String name;
    private String time;
    private String state;
    private String password;
    private int roleId;
    private String roleName;
    @Transient
    private String token;
}
