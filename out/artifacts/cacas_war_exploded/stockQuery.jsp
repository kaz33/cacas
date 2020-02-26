<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>咔咔仕</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

	<!--标准mui.css-->
	<link rel="stylesheet" href="css/mui.min.css">
	<!--App自定义的css-->
	<!--<link rel="stylesheet" type="text/css" href="../css/app.css"/>-->
	<style>
		.amount {
			font-size:18px;
			font-weight:bold;
			float: right;
			margin:-2px -25px;
		}

		a div {
			float: left;
		}
	</style>
</head>
<body>
<header class="mui-bar mui-bar-nav">
	<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	<h1 class="mui-title">出入库查询</h1>
</header>

<div class="mui-content">
	<ul id="list" class="mui-table-view mui-table-view-chevron">
		<c:forEach items="${list}" var="stock">
		<li class="mui-table-view-cell mui-collapse">
			<a class="mui-navigate-right" href="#" month="${stock.month}">
				<div style="width: 25%;">${stock.month}月</div>
				<div style="width: 45%;">入库：￥${stock.inSum}</div>
				<div style="width: 30%;">出库：￥${stock.outSum}</div>
			</a>
		</li>
		</c:forEach>
	</ul>
</div>
</body>
<script src="js/mui.min.js"></script>
<script src="js/ajax.js"></script>
<script>
	mui.init({
		swipeBack: true //启用右滑关闭功能
	});

	//alert(mui('.mui-collapse').length);
	mui('#list').on('tap', '.mui-navigate-right', function() {
		let month = this.getAttribute("month");

		if (this.nextSibling.nodeType == 1) {
			return;
		}

		ajax({
			method:'POST',
			url: 'stockQueryByMon.do',
			focus:this,
			data: {
				'month': month,
			},
			success: function (response,focusNode) {
				let objs = JSON.parse(response);
				let obj,ul,li,a,dv;
				ul = document.createElement("ul");
				ul.setAttribute("class", "mui-table-view mui-table-view-chevron");
				for(obj of objs) {
					li = document.createElement("li");
					li.setAttribute("class", "mui-table-view-cell");
					a = document.createElement("a");
					a.setAttribute("class", "detailinfo");
					a.setAttribute("sid",obj.sid);
					dv = document.createElement("div");
					dv.setAttribute("style","float: left;width: 40%;");
					dv.append(obj.dtime);
					a.append(dv);
					dv = document.createElement("div");
					dv.setAttribute("style","float: left;width: 20%;");
					dv.append(obj.inout==0?'入库':'出库');
					a.append(dv);
					dv = document.createElement("div");
					dv.setAttribute("style","float: left;width: 40%;");
					dv.setAttribute("class","mui-ellipsis");
					dv.append(obj.remark || '无');
					a.append(dv);
					li.append(a);
					ul.append(li);
				}
				focusNode.after(ul);
			}
		});
	});

	mui('#list').on('tap', '.detailinfo', function() {
		let id = this.getAttribute("sid");
		location.href = "stockQueryDetail.do?id="+id;
	});
</script>
</html>
