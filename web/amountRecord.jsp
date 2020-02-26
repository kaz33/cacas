<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta charset="utf-8">
		<title>咔咔仕记账</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!--标准mui.css-->
		<link rel="stylesheet" href="css/mui.min.css">
		<link rel="stylesheet" href="css/mui.picker.min.css" />
		<!--App自定义的css-->
		<!-- <link rel="stylesheet" type="text/css" href="../css/app.css" /> -->
		<style>
			h5 {
				margin: 5px 7px;
			}
			
			#dtSelect {
				font-size: 16px;
				padding: 8px;
				margin: 3px;
			}
			
			* {
				-webkit-touch-callout: none;
				-webkit-user-select: none;
			}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">记账</h1>
		</header>
		<div class="mui-content">
			<div class="mui-content-padded" style="margin: 5px;">
				<form class="mui-input-group" action="amountRecord.do">
					<div class="mui-input-row">
						<label>金额</label>
						<input type="text" name="amount" class="mui-input-clear" placeholder="输入金额" pattern="[0-9]{4}">
					</div>
					<div class="mui-input-row">
						<label>日期</label>
						<input type="text" name="datetime" class="mui-input-clear" placeholder="普通输入框" readonly>
					</div>
					<button type="button" id='dtSelect' data-options='{"type":"date","beginYear":2019,"endYear":2022}' class="btn mui-btn mui-btn-block">选择日期...</button>
					<div class="mui-button-row">
						<button id="confirm" type="button" class="mui-btn mui-btn-primary">确认</button>&nbsp;&nbsp;
						<button type="button" class="mui-btn mui-btn-danger">取消</button>
					</div>
				</form>
			</div>
		</div>
		<script src="js/mui.min.js"></script>
		<script src="js/mui.picker.min.js"></script>
		<script src="js/comm.js"></script>
		<script>
			mui.init({
				swipeBack: true //启用右滑关闭功能
			});

			<c:if test="${result != null}">
			goBackDialog("${result?'成功！':'失败！'}");
			</c:if>

			var result = mui('input')[1];
			var btn = mui('.btn')[0];

			btn.addEventListener('tap', function() {
				var _self = this;
				if (_self.picker) {
					_self.picker.show(function(rs) {
						result.value = rs.text;
						_self.picker.dispose();
						_self.picker = null;
					});
				} else {
					var optionsJson = this.getAttribute('data-options') || '{}';
					var options = JSON.parse(optionsJson);
					var id = this.getAttribute('id');
					/*
					 * 首次显示时实例化组件
					 * 示例为了简洁，将 options 放在了按钮的 dom 上
					 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
					 */
					_self.picker = new mui.DtPicker(options);
					_self.picker.show(function(rs) {
						/*
						 * rs.value 拼合后的 value
						 * rs.text 拼合后的 text
						 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
						 * rs.m 月，用法同年
						 * rs.d 日，用法同年
						 * rs.h 时，用法同年
						 * rs.i 分（minutes 的第二个字母），用法同年
						 */
						result.value = rs.text;
						/* 
						 * 返回 false 可以阻止选择框的关闭
						 * return false;
						 */
						/*
						 * 释放组件资源，释放后将将不能再操作组件
						 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
						 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
						 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
						 */
						_self.picker.dispose();
						_self.picker = null;
					});
				}

			}, false);

			mui('#confirm')[0].addEventListener('tap', function() {
				if(!validate.isNumber(mui('input')[0].value)) {
					mui.toast('金额只能输入数字！');
					return;
				}
				mui('.mui-input-group')[0].submit();
			});

			let dtime = document.getElementsByName("datetime");
			dtime[0].value = new Date().Format("yyyy-MM-dd");
		</script>
	</body>

</html>
