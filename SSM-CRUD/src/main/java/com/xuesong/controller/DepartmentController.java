package com.xuesong.controller;

import com.xuesong.bean.Department;
import com.xuesong.bean.Msg;
import com.xuesong.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @description:获取部门信息
 * @author: Snow
 * @create: 2020-06-30 18:23
 **/
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /*返回所有信息*/
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }

}
