package com.springboot.entity;

import lombok.Data;

@Data
public class Permissions {
    private int id;
    private String name;
    private String routing;
    private String code;
    private String state;
    private String role_prm;
}
