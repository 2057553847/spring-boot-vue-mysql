package com.springboot.controller;


import com.github.pagehelper.PageInfo;
import com.springboot.common.AutoLog;
import com.springboot.common.Result;
import com.springboot.entity.Log;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import com.springboot.service.LogService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/log")
public class LogController {
    @Resource
    private LogService service;


    @GetMapping("/pageSelect")
    public Result pageSelect(Params params){
        PageInfo<Log> info = service.pageSelect(params);
        return Result.success(info);
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Log> list){
        for (Log log : list){
            service.delete(log.getId());
        }
        return Result.success();
    }
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        service.delete(id);
        return Result.success();
    }
}
