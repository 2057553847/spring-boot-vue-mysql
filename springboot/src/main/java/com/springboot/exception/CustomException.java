package com.springboot.exception;

// 自定义异常类，继承自RuntimeException
public class CustomException extends RuntimeException{
    // 私有化属性msg
    private String msg;

    // 构造方法，传入msg参数
    public  CustomException(String msg){
        this.msg = msg;
    }
    // getter方法，获取msg的值
    public String getMsg(){
        return msg;
    }
    // setter方法，设置msg的值
    public void setMsg(String msg){
        this.msg = msg;
    }
}
