<%--
  Created by IntelliJ IDEA.
  User: liukai
  Date: 2020/2/9
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="utf-8">
    <title>咔咔仕主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!--标准mui.css-->
    <link rel="stylesheet" href="css/mui.min.css">
</head>

<body>
<div id="offCanvasWrapper" class="mui-off-canvas-wrap mui-draggable">
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
                <ul class="mui-table-view mui-grid-view mui-grid-9">
                    <c:if test="${param.type == null || param.type == 'sale'}">
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="amountRecord.jsp">
                            <span class="mui-icon mui-icon-compose"></span>
                            <div class="mui-media-body">营业额记录</div>
                        </a></li>
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="amountQuery.do">
                            <span class="mui-icon mui-icon-email"></span>
                            <div class="mui-media-body">营业额查询</div>
                        </a></li>
                    </c:if>
                    <c:if test="${param.type == 'stock'}">
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a
                                href="stockQueryForOpt.do?optType=out">
                            <span class="mui-icon mui-icon-minus"></span>
                            <div class="mui-media-body">出库</div>
                        </a></li>
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a
                                href="stockQueryForOpt.do?optType=in">
                            <span class="mui-icon mui-icon-plus"></span>
                            <div class="mui-media-body">入库</div>
                        </a></li>
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a
                                href="auxiliaryQuery4Add.do">
                            <span class="mui-icon mui-icon-checkmarkempty"></span>
                            <div class="mui-media-body">其它入库</div>
                        </a></li>
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="stockQuerySum.do">
                            <span class="mui-icon mui-icon-search"></span>
                            <div class="mui-media-body">出入库查询</div>
                        </a></li>
                    </c:if>
                    <c:if test="${param.type == 'goods'}">
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="goodsAdd.jsp">
                            <span class="mui-icon mui-icon-plus"></span>
                            <div class="mui-media-body">添加物品</div>
                        </a></li>
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="goodsQuery.do">
                            <span class="mui-icon mui-icon-search"></span>
                            <div class="mui-media-body">查询物品</div>
                        </a></li>
                    </c:if>
                    <c:if test="${param.type == 'query'}">
                        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="QueryOutByMon.do">
                            <span class="mui-icon mui-icon-search"></span>
                            <div class="mui-media-body">分类统计</div>
                        </a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <!-- off-canvas backdrop -->
        <div class="mui-off-canvas-backdrop"></div>
    </div>
</div>
</body>
<script src="js/mui.min.js"></script>
<script src="js/comm.js"></script>
<script>
    mui.init();
    initSideMenu(mui,document);
</script>
</html>
