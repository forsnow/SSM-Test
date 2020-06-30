package com.xuesong.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @description:通用的返回类
 * @author: Snow
 * @create: 2020-06-29 11:29
 **/
public class Msg {
    //状态码 100成功 200失败
    private int code;
    //提示信息
    private String msg;
    //用户返回的给浏览器的数据
    private Map<String,Object> map = new HashMap<>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key, Object value){
        this.getMap().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }
}
