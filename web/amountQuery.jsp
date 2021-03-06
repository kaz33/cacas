<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--查询本年按月汇总的销售额，点击每月通过ajax请求查询每天详细的销售 -->
<html>
<head>
    <meta charset="utf-8">
    <title>账本查询</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!--标准mui.css-->
    <link rel="stylesheet" href="css/mui.min.css">
    <!--App自定义的css-->
    <!--<link rel="stylesheet" type="text/css" href="../css/app.css"/>-->
    <style>
        .amount {
            font-size: 18px;
            font-weight: bold;
            float: right;
            margin: -2px -25px;
        }

        .amountDetail {
            font-size: 18px;
            float: right;
            margin: -2px 5px;
        }
    </style>
</head>
<body>
<div id="offCanvasWrapper" class="mui-off-canvas-wrap mui-draggable">
    <!--侧滑菜单部分-->
    <jsp:include page="sideMenu.jsp"/>
    <!--主界面部分-->
    <div class="mui-inner-wrap">
        <header class="mui-bar mui-bar-nav">
            <a href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-left"></a>
            <!--a class="mui-action-back mui-btn mui-btn-link mui-pull-right">关闭</a-->
            <h1 class="mui-title">咔咔仕信息管理系统</h1>
        </header>
        <div id="offCanvasContentScroll" class="mui-content mui-scroll-wrapper">

            <div class="mui-content">
                <ul id="list" class="mui-table-view mui-table-view-chevron">
                    <c:forEach items="${list}" var="vo">
                        <li class="mui-table-view-cell mui-collapse">
                            <a class="mui-navigate-right" href="#" month="${vo.month}">
                                <span class="amount">${vo.amount}</span>${vo.maonthLabel}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div><!-- off-canvas backdrop -->
        <div class="mui-off-canvas-backdrop"></div>
    </div>
</div>
</body>
<script src="js/mui.min.js"></script>
<script src="js/ajax.js"></script>
<script src="js/comm.js"></script>
<script>
    mui.init({
        swipeBack: true //启用右滑关闭功能
    });


    initSideMenu(mui,document);

    mui('#list').on('tap', '.mui-navigate-right', function () {
        let month = this.getAttribute("month");

        if (this.nextSibling.nodeType == 1) {
            return;
        }

        ajax({
            method: 'POST',
            url: 'amountDetail.do',
            focus: this,
            data: {
                'month': month,
            },
            success: function (response, focusNode) {
                let objs = JSON.parse(response);
                let obj, ul, li, a, sp;
                ul = document.createElement("ul");
                ul.setAttribute("class", "mui-table-view mui-table-view-chevron");
                for (obj of objs) {
                    li = document.createElement("li");
                    li.setAttribute("class", "mui-table-view-cell");
                    a = document.createElement("a");
                    a.setAttribute("href", "#");
                    sp = document.createElement("span");
                    sp.setAttribute("class", "amountDetail");
                    sp.append(obj.amount);
                    a.append(sp);
                    a.append(obj.maonthLabel);
                    li.append(a);
                    ul.append(li);
                }
                focusNode.after(ul);
            }
        });
    })
</script>
</html>
