package com.springboot.entity;

import lombok.Data;

@Data
public class Params {
    private String name;
    private String description;
    private String username;
    private Integer pageNum;
    private Integer pageSize;
}
