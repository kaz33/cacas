<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="sumAmount" value="0"/>
<c:set var="sumQty" value="0"/>
<html>
<head>
    <meta charset="utf-8">
    <title>咔咔仕</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!--标准mui.css-->
    <link rel="stylesheet" href="css/mui.min.css">
    <style>
        .mui-table h4, .mui-table h5, .mui-table .mui-h5, .mui-table .mui-h6, .mui-table p {
            margin-top: 0;
        }

        .mui-table h4 {
            line-height: 21px;
            font-weight: 500;
        }
    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">${opt=='IN'?'入':'出'}库详细</h1>
</header>
<div class="mui-content">
    <form action="stockConfirm.do">
        <input type="hidden" name="type" value="${opt}">
        <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
            <c:forEach items="${qtys}" var="q" varStatus="s">
                <input type="hidden" name="gid" value="${ids[s.index]}">
                <input type="hidden" name="qty" value="${q}">
                <c:set var="sumAmount" value="${sumAmount + q*prices[s.index]}"/>
                <c:set var="sumQty" value="${sumQty + q}"/>
                <li class="mui-table-view-cell">
                    <div class="mui-table">
                        <div class="mui-table-cell mui-col-xs-8">
                            <div style="margin-bottom: 5px;">名称：${gnames[s.index]}</div>
                            <div>数量：${q}</div>
                        </div>
                        <div class="mui-table-cell mui-col-xs-4 mui-text-left" style="vertical-align: middle;">
                            <span>价格：${q*prices[s.index]}</span>
                        </div>
                    </div>
                </li>
            </c:forEach>
            <li class="mui-table-view-cell">
                <div class="mui-table">
                    <div class="mui-table-cell mui-col-xs-8" >
                        总共：${sumQty}件
                    </div>
                    <div class="mui-table-cell mui-col-xs-4 mui-text-left">
                        总价：${sumAmount}
                    </div>
                </div>
            </li>
        </ul>
        <h5>备注：</h5>
        <div class="mui-input-row" style="margin: 10px 5px;">
            <textarea id="textarea" name="remark" rows="5">${sumQty}件,￥${sumAmount}</textarea>
        </div>
        <div class="mui-button-row">
            <button id="confirm" type="button" class="mui-btn mui-btn-primary">确认</button>&nbsp;&nbsp;
            <button type="button" class="mui-btn mui-btn-danger">取消</button>
        </div>
    </form>
</div>
</body>
<script src="js/mui.min.js"></script>
<script src="js/comm.js"></script>
<script>
    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    mui('#confirm')[0].addEventListener('tap', function() {
        mui('form')[0].submit();
    });

    <c:if test="${result != null}">
    goBackDialog("${result?'成功！':'失败！'}");
    </c:if>

</script>
</html>