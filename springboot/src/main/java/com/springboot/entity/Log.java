package com.springboot.entity;

import lombok.Data;

@Data
public class Log {
    private Integer id;
    private String name;
    private String time;
    private String username;
    private String ip;

    public Log(Integer id, String name, String time, String username, String ip) {
        this.id = id;
        this.name = name;
        this.time = time;
        this.username = username;
        this.ip = ip;
    }
}
