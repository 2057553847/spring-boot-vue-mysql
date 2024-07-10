package com.springboot.common;

import lombok.Data;

@Data
public class Result {
    // 定义成功码
    private static final String SUCCESS = "0";
    // 定义错误码
    private static final String ERROR = "-1";

    // 定义Result类
    private String code;
    private String msg;
    private Object data;

    // 成功方法
    public static Result success() {
        Result result = new Result();
        result.setCode(SUCCESS);
        return result;
    }

    // 成功带数据方法
    public static Result success(Object data) {
        Result result = new Result();
        result.setCode(SUCCESS);
        result.setData(data);
        return result;
    }

    // 错误方法
    public static Result error(String msg) {
        Result result = new Result();
        result.setCode(ERROR);
        result.setMsg(msg);
        return result;
    }
}
