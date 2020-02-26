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
			.mui-table h4,.mui-table h5,.mui-table .mui-h5,.mui-table .mui-h6,.mui-table p{
		        margin-top: 0;
		    }
		    .mui-table h4{
		        line-height: 21px;
		        font-weight: 500;
		    }
			
			.mui-col-xs-8 span {
				margin-bottom: 5px;
			}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
		    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
		    <h1 class="mui-title">${stock.inout==0?'入':'出'}库详细</h1>
		</header>
		<div class="mui-content">
		    <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
		        <li class="mui-table-view-cell">
					<div class="mui-table">
						<div class="mui-table-cell">
							操作：${stock.inout==0?'入':'出'}库
						</div>
						<div class="mui-table-cell">
							时间：${stock.dtime}
						</div>
					</div>
		        </li>
				<c:forEach items="${stock.goods}" var="good">
					<c:set var="sumAmount" value="${sumAmount + good.price}"/>
					<c:set var="sumQty" value="${sumQty + good.stockQty}"/>
				<li class="mui-table-view-cell">
		            <div class="mui-table">
		                <div class="mui-table-cell mui-col-xs-6">
		                    <div class="mui-h4" style="margin-bottom: 5px;">名称：${good.name}</div>
		                    <div class="mui-h4">数量：${good.stockQty}</div>
		                </div>
		                <div class="mui-table-cell mui-col-xs-3" style="vertical-align: middle;">
		                    <span class="mui-h4">￥${good.price}</span>
		                </div>
						<div class="mui-table-cell mui-col-xs-3" style="vertical-align: middle;">
						    <span class="mui-h4">库存：${good.statis==0?'无':good.statis}</span>
						</div>
		            </div>
		        </li>
				</c:forEach>
				<li class="mui-table-view-cell ">
					<div class="mui-table">
					<div class="mui-table-cell">
						总共：${sumQty}件
					</div>
					<div class="mui-table-cell">
						￥${sumAmount}
					</div>
					</div>
				</li>
		    </ul>
			<div class="mui-input-row" style="margin: 10px 15px;">
				备注：${stock.remark}
			</div>
		</div>
	</body>
	<script src="js/mui.min.js"></script>
	<script>
		mui.init({
			swipeBack:true //启用右滑关闭功能
		});
	</script>
</html>