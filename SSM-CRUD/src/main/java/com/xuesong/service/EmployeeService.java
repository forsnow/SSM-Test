package com.xuesong.service;

import com.xuesong.bean.Employee;
import com.xuesong.bean.Msg;
import com.xuesong.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: Snow
 * @create: 2020-06-17 11:09
 **/
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    //员工保存
    public Msg saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
        return Msg.success();
    }
}
