package com.springboot.service.Impl;

import cn.hutool.core.date.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springboot.entity.Notice;
import com.springboot.entity.Params;
import com.springboot.exception.CustomException;
import com.springboot.mapper.NoticeMapper;
import com.springboot.service.NoticeService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    private NoticeMapper mapper;

    @Override
    public void add(Notice notice) {
        if (notice.getName() == null){
            throw new CustomException("请输入公告标题！");
        }
        if (notice.getContent() == null){
            throw new CustomException("请输入公告内容！");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sdf.format(new Date());
        notice.setTime(time);
        mapper.add(notice);
    }

    @Override
    public void update(Notice notice) {
        notice.setTime(DateUtil.now());
        mapper.update(notice);
    }

    @Override
    public void delete(Integer id) {mapper.delete(id);}

    @Override
    public List<Notice> selectAll() {return mapper.selectAll();}

    @Override
    public PageInfo<Notice> pageSelect(Params params) {
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Notice> list = mapper.pageSelect(params);
        return PageInfo.of(list);
    }
}
