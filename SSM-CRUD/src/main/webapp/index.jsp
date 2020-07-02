<%--
  Created by IntelliJ IDEA.
  User: Snow
  Date: 2020/6/17
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
    <title>Employee List</title>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<!--
web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名http://localhost:3306/crud
 -->
<body>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empNameAdd_input" class="col-sm-2 control-label">empName</label>
                        <span id="helpBlock1" class="help-block">..</span>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empNameAdd_input" placeholder="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emailAdd_input" class="col-sm-2 control-label">email</label>
                        <span id="helpBlock2" class="help-block">..</span>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="emailAdd_input" placeholder="test@xuesong.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="empNameAdd_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderAdd_input1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderAdd_input2" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="empNameAdd_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_select">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button type="button" class="btn btn-primary" id="empAddModal_btn">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>EmpName</th>
                        <th>gender</th>
                        <th>Email</th>
                        <th>DeptName</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>

        <%--分页条--%>
        <div class="col-md-6 col-md-offset-6" id="nav_info_area"></div>
    </div>
</div>


<script type="text/javascript">
    var totalRecord;

    //页面完成后直接发送一个ajax请求，要到分页数据
    $(function() {
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //console.log(result)
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        })
    }

    function build_emps_table(result) {
        //清空表格
        $("#emps_table tbody").empty();

        var emps = result.map.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIDTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            /**
             <button type="button" class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             <button type="button" class="btn btn-danger btn-sm">
             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
             删除
             </button>
             */

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(empIDTd)
                .append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {
        //清空信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前"+result.map.pageInfo.pageNum+"页,总"
         +result.map.pageInfo.pages+"页,总"
         +result.map.pageInfo.total+"页");

        totalRecord = result.map.pageInfo.pages;

    }

    function build_page_nav(result) {
        //清空信息
        $("#nav_info_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        //前一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //后一页

        if (result.map.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.map.pageInfo.pageNum -1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.map.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.map.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.map.pageInfo.pages);
            });
        }


        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi)
        //页码号12345 遍历添加123到ul中
        $.each(result.map.pageInfo.navigatepageNums,function (index,item) {
           //<li><a href="#">1</a></li>
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.map.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        })
        //添加后一页和末页
        ul.append(nextPageLi).append(lastPageLi)

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#nav_info_area");



    }

    //点击新增按钮弹出模态框
    $("#empAddModal_btn").click(function () {
        //发送ajax请求 查出部门信息 显示在下拉列表中
        getDept();

        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        })
    })

    //查出所有的部门信息并显示在下来列表中
    function getDept() {
        $("#empAddModal select").empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "get",
            success:function (result) {
                //console.log(result);
                //"code":100,"msg":"处理成功","map":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                //$("#empAddModal select").append()

                //遍历部门信息
                $.each(result.map.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId)
                    optionEle.appendTo("#empAddModal select");
                })
            }
        })

    }

    //校验表单数据
    function validate_add_form(){
        //1.拿到要校验的数据，使用正则表达式校验
        var empName = $("#empNameAdd_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文支持大小写和_")
            $("#empNameAdd_input").parent().addClass("has-error");
            $("#helpBlock1").text("用户名可以是2-5位中文或者6-16位英文支持大小写和_");
            return false;
        }else {
            $("#empNameAdd_input").parent().addClass("has-success");
            $("#helpBlock1").text("√");
        }


        //2.校验邮箱
        var email = $("#emailAdd_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regEmail.test(email)){
            //alert("请输入正确的邮箱格式")
            $("emailAdd_input").parent().addClass("has-error");
            $("#helpBlock2").text("请输入正确的邮箱格式QAQ");
            return false;
        }else {
            $("emailAdd_input").parent().addClass("has-success");
            $("#helpBlock1").text("√");
        }

        return true;

    }

    $("#emp_save").click(function () {
        //点击保存先对提交给数据库的数据进行校验
        if(!validate_add_form()){
            return false;
        }

        //1.将表单内容提交给服务器进行保存
        $.ajax({
            url : "${APP_PATH}/emps",
            type : "post",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                //关闭模态框
                $("#empAddModal").modal('hide');
                //来到最后一页
                to_page(totalRecord);

            }
        })

    })


</script>

</body>
</html>
