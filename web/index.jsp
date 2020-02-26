<%--
  Created by IntelliJ IDEA.
  User: liukai
  Date: 2020/2/9
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <meta charset="utf-8">
  <title>咔咔仕主页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">

  <!--标准mui.css-->
  <link rel="stylesheet" href="css/mui.min.css">
  <!--App自定义的css-->
  <!--<link rel="stylesheet" type="text/css" href="../css/app.css"/>-->
</head>

<body>

<header class="mui-bar mui-bar-nav">
  <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
  <h1 class="mui-title">咔咔仕管理系统</h1>
</header>
<div class="mui-content">
  <ul class="mui-table-view mui-grid-view mui-grid-9">
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="amountRecord.jsp">
      <span class="mui-icon mui-icon-home"></span>
      <div class="mui-media-body">营业额记录</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="amountQuery.do">
      <span class="mui-icon mui-icon-email"></span>
      <div class="mui-media-body">营业额查询</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="stockQueryForOpt.do?optType=out">
      <span class="mui-icon mui-icon-chatbubble"></span>
      <div class="mui-media-body">出库</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="stockQueryForOpt.do?optType=in">
      <span class="mui-icon mui-icon-location"></span>
      <div class="mui-media-body">入库</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="stockQuerySum.do">
      <span class="mui-icon mui-icon-search"></span>
      <div class="mui-media-body">出入库查询</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="goodsAdd.jsp">
      <span class="mui-icon mui-icon-phone"></span>
      <div class="mui-media-body">添加物品</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="goodsQuery.do">
      <span class="mui-icon mui-icon-gear"></span>
      <div class="mui-media-body">查询物品</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="auxiliaryQuery4Add.do">
      <span class="mui-icon mui-icon-info"></span>
      <div class="mui-media-body">其它记账</div></a></li>
    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="QueryOutByMon.do">
      <span class="mui-icon mui-icon-more"></span>
      <div class="mui-media-body">分类统计</div></a></li>
  </ul>
</div>
</body>
<script src="js/mui.min.js"></script>
<script>
  mui.init({
    swipeBack:true //启用右滑关闭功能
  });
</script>
</html>
