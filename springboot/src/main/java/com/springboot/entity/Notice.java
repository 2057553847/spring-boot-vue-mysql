package com.springboot.entity;

import lombok.Data;

@Data
public class Notice {
    private int id;
    private String name;
    private String content;
    private String time;
}
