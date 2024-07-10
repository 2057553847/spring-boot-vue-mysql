package com.springboot.entity;

import lombok.Data;

import javax.persistence.Table;
import javax.persistence.Transient;

@Data
public class Role {
    private int id;
    private String name;
    private String description;
    private String code;
    private String permissions;
    private int permissionsId;
    private String permName;
    private String admin;
    private Integer pageNum;
    private Integer pageSize;
}
