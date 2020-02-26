<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
		    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
		    <h1 class="mui-title">物品列表</h1>
		</header>
		<div class="mui-content">
		    <ul class="mui-table-view">
				<c:forEach items="${list}" var="good">
		        <li class="mui-table-view-cell">
		            <div class="mui-table">
		                <div class="mui-table-cell mui-col-xs-5">
		                    ${good.name}
		                </div>
		                <div class="mui-table-cell mui-col-xs-4 mui-text-left">
		                    ￥${good.price}
		                </div>
						<div class="mui-table-cell mui-col-xs-3 mui-text-left">
						    ${good.stockQty} ${good.spec}
						</div>
		            </div>
		        </li>
				</c:forEach>
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