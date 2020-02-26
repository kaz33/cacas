<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>
        ${type=='IN'?'入':'出'}库
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!--标准mui.css-->
    <link rel="stylesheet" href="css/mui.min.css">
    <style>
        .tMargin {
            margin-bottom: 5px;
        }

        #price {
            width: 80px;
            height: 30px;
            border: 1px solid #bbbbbb;
            border-radius: 2px;
            text-align: center;
        }
    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">
        ${type=='IN'?'入':'出'}库
    </h1>
</header>
<div class="mui-content">
    <form class="mui-input-group" action="stockSave.do">
        <input type="hidden" name="type" value="${type}">
        <ul id="goodsList" class="mui-table-view mui-table-view-striped mui-table-view-condensed"
            style="background-color: #EFEFF4;">
            <c:forEach items="${list}" var="goods">
                <input type="hidden" name="gname" value="${goods.name}">
            <div class="mui-card">
                <li class="mui-table-view-cell">
                    <div class="mui-slider-right mui-disabled">
                        <a class="mui-btn mui-btn-red">删除</a>
                    </div>
                    <div class="mui-slider-handle mui-table">
                        <div class="mui-table-cell">
                            <div class="mui-table tMargin" style="border-bottom: 1px solid #bbbbbb;">
                                <div class="mui-table-cell mui-col-xs-9">物品名：${goods.name}</div>
                                <div class="mui-table-cell mui-col-xs-3">库存：${goods.stockQty}</div>
                                <input type="hidden" name="gid" value="${goods.id}">
                            </div>
                            <div class="mui-table tMargin">
                                <div class="mui-table-cell">
                                    ${type=='IN'?'采购':'出库'}数量：
                                    <div class="mui-numbox" style="width: 120px;height: 35px;">
                                        <button class="mui-btn mui-btn-numbox-minus" type="button">-</button>
                                        <input class="mui-input-numbox" type="number" name="qty"/>
                                        <button class="mui-btn mui-btn-numbox-plus" type="button">+</button>
                                    </div>
                                </div>
                            </div>
                            <div class="mui-table">
                                <div class="mui-table-cell">
                                    ${type=='IN'?'采购':'销售'}价格：
                                    <div style="display:inline-block;">
                                        <input type="text" id="price" name="price" value="${goods.price}">
                                        <div>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
					</div>
                </li>
            </div>
            </c:forEach>
        </ul>
	</form>
    <div class="mui-button-row">
        <button id="confirm" type="button" class="mui-btn mui-btn-primary">确认</button>&nbsp;&nbsp;
        <button type="button" class="mui-btn mui-btn-danger">取消</button>
    </div>
</div>
<script src="js/mui.min.js"></script>
<script>
    mui.init();
    (function ($) {
        let btnArray = ['确认', '取消'];
        //向左拖拽后显示操作图标，释放后自动触发的业务逻辑
        $('#goodsList').on('slideleft', '.mui-table-view-cell', function (event) {
            var elem = this;
            mui.confirm('确认删除该条记录？', '', btnArray, function (e) {
                if (e.index == 0) {
                    elem.parentNode.removeChild(elem);
                } else {
                    setTimeout(function () {
                        $.swipeoutClose(elem);
                    }, 0);
                }
            });
        });

    })(mui);

    mui('#confirm')[0].addEventListener('tap', function() {
        mui('.mui-input-group')[0].submit();
    });
</script>
</body>

</html>