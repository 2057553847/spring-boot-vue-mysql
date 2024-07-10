package com.springboot.controller;

import com.github.pagehelper.PageInfo;
import com.springboot.common.Result;
import com.springboot.entity.Params;
import com.springboot.entity.Permissions;
import com.springboot.entity.Role;
import com.springboot.service.PermissionsService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/permissions")
public class PermissionsController {
    @Resource
    private PermissionsService service;

    @GetMapping("/pageSelect")
    public Result pageSelect(Params params){
        PageInfo<Permissions> info = service.pageSelect(params);
        return Result.success(info);
    }
    @GetMapping
    public Result findAll(){
        return Result.success(service.findAll());
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Permissions> list){
        for (Permissions permissions : list){
            service.delete(permissions.getId());
        }
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        service.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result add(@RequestBody Permissions permissions){
        if (permissions.getId() == 0){
            service.add(permissions);
        } else {
            service.update(permissions);
        }
        return Result.success();
    }
}
