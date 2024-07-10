package com.springboot.mapper;
import com.springboot.entity.Log;
import com.springboot.entity.Params;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
@Mapper
public interface LogMapper {
    List<Log> pageSelect(@Param("params")Params params);

    void add(Log log);

    void delete(Integer id);
}
