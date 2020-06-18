package com.xuesong.test;

import com.xuesong.bean.Employee;
import com.xuesong.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * @description:测试类
 * @author: Snow
 * @create: 2020-06-17 10:11
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void test01(){
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        for (Employee employee : employees) {
            System.out.println(employee+employee.getDepartment().getDeptName());
        }
    }

    @Test
    public void test02(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uuid, "M", uuid+"@xuesong.com", 1));
        }
    }

}
