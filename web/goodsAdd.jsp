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
	<link rel="stylesheet" href="css/mui.picker.css"/>
	<link rel="stylesheet" href="css/mui.poppicker.css"/>
	<style>
		h5 {
			margin: 5px 7px;
		}

		#userResult {
			width: 15%;
			height: 30px;
			float: left;
			text-align: center;
			border-left: 1px solid #bbbbbb;
			border-bottom:1px solid #bbbbbb;
			border-top:1px solid #bbbbbb;
			border-radius: 2px 0 0 2px;
			margin: 5px 0 5px 0;
		}

		#showUserPicker {
			height: 30px;
			float: left;
			margin: 5px 0 5px 0;
			border-radius: 0 2px 2px 0;
			border-color: #bbbbbb;
		}

	</style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
	<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	<h1 class="mui-title">添加物品</h1>
</header>
<div class="mui-content">
	<div class="mui-content-padded" style="margin: 5px;">
		<form name="goodForm" class="mui-input-group" action="goodsAdd.do">
			<div class="mui-input-row">
				<label>名称：</label>
				<input type="text" name="gname" class="mui-input-clear" placeholder="必填">
			</div>
			<div class="mui-input-row">
				<label>价格：</label>
				<input type="text" name="price" class="mui-input-clear" placeholder="必填">
			</div>
			<div class="mui-input-row">
				<label>规格：</label>
				<input type="text" name="spec" class="mui-input-clear" placeholder="升/千克/个等">
			</div>
			<div class="mui-input-row">
				<label>单位：</label>
				<input id="userResult" type="text" readonly><input type="hidden" name="unit"/>
				<button id="showUserPicker" type="button">选择</button>
			</div>
			<div class="mui-input-row">
				<label>统计库存：</label>
				<div id="switch" class="mui-switch" style="float: left;">
					<div class="mui-switch-handle"></div>
				</div><input type="hidden" name="statis" value="0" style="float: left;width: 40px;"/>
			</div>
			<div class="mui-button-row">
				<button id="confirm" type="button" class="mui-btn mui-btn-primary">确认</button>&nbsp;&nbsp;
				<button type="button" class="mui-btn mui-btn-danger">取消</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>
<script src="js/comm.js"></script>
<script src="js/mui.min.js"></script>
<script src="js/mui.picker.js"></script>
<script src="js/mui.poppicker.js"></script>
<script>
	(function($, doc) {
		$.init({
			swipeBack: true //启用右滑关闭功能
		});

		<c:if test="${result != null}">
		goBackDialog("${result?'成功！':'失败！'}");
		</c:if>

		$.ready(function() {
			//普通示例
			//TODO 此处可以修改为读取数据库
			var userPicker = new $.PopPicker();
			userPicker.setData([{
				value: '0',
				text: '袋'
			}, {
				value: '1',
				text: '瓶'
			}, {
				value: '2',
				text: '捆'
			}, {
				value: '3',
				text: '个'
			}, {
				value: '4',
				text: '箱'
			}]);
			var showUserPickerButton = doc.getElementById('showUserPicker');
			var userResult = doc.getElementById('userResult');
			showUserPickerButton.addEventListener('tap', function(event) {
				userPicker.show(function(items) {
					userResult.value = items[0].text;
					userResult.nextSibling.value = items[0].value;
					//返回 false 可以阻止选择框的关闭
					//return false;
				});
			}, false);

			var statis = doc.getElementById("switch");
			statis.addEventListener('toggle', function(event) {
				//event.detail.isActive 可直接获取当前状态
				this.nextSibling.value = (event.detail.isActive ? 1 : 0);
			});

			mui('#confirm')[0].addEventListener('tap', function() {
				if(!validate.isEmpty(doc.goodForm.gname.value)) {
					mui.toast('名称不能为空！');
					return;
				}

				if(!validate.isNumber(doc.goodForm.price.value)) {
					mui.toast('金额不能为空或必须为数字！');
					return;
				}
				mui('form')[0].submit();
			});
		});


	})(mui, document);
</script>