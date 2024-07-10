package com.springboot.controller;


import com.github.pagehelper.PageInfo;
import com.springboot.common.Result;
import com.springboot.entity.Admin;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import com.springboot.service.RoleService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/role")
public class RoleController {
    @Resource
    private RoleService service;


    @GetMapping("/pageSelect")
    public Result pageSelect(Params params){
        PageInfo<Role> info = service.pageSelect(params);
        return Result.success(info);
    }

    @GetMapping
    public Result findAll(){
        return Result.success(service.findAll());
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Role> list){
        for (Role role : list){
            service.delete(role.getId());
        }
        return Result.success();
    }
    @PostMapping
    public Result add(@RequestBody Role role){
        if (role.getId() == 0){
            service.add(role);
        } else {
          service.update(role);
        }
        return Result.success();
    }
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        service.delete(id);
        return Result.success();
    }
}
