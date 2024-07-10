package com.springboot.controller;


import com.github.pagehelper.PageInfo;
import com.springboot.common.AutoLog;
import com.springboot.common.Result;
import com.springboot.entity.Admin;
import com.springboot.entity.Notice;
import com.springboot.entity.Params;
import com.springboot.entity.Role;
import com.springboot.service.NoticeService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/notice")
public class NoticeController {
    @Resource
    private NoticeService service;

    @PostMapping
    public Result add(@RequestBody Notice notice){
        if (notice.getId() == 0){
            service.add(notice);
        }else {
         service.update(notice);
        }
        return Result.success();
    }
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        service.delete(id);
        return Result.success();
    }
    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Notice> list){
        for (Notice notice : list){
            service.delete(notice.getId());
        }
        return Result.success();
    }

    @GetMapping
    public Result selectAll(){
        List<Notice> list = service.selectAll();
        return Result.success(list);
    }

    @GetMapping("/pageSelect")
    public Result pageSelect(Params params){
        PageInfo<Notice> info = service.pageSelect(params);
        return Result.success(info);
    }
}
