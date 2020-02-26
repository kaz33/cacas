<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--TODO 显示时需要读取数据库填写价格和单位 -->
<html>
<head>
	<meta charset="utf-8">
	<title>咔咔仕</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

	<link rel="stylesheet" href="css/mui.min.css">
	<link rel="stylesheet" href="css/mui.picker.min.css"/>
	<link rel="stylesheet" href="css/mui.poppicker.css"/>
	<style>
		.mui-table h4,.mui-table h5,.mui-table .mui-h5,.mui-table .mui-h6,.mui-table p{
			margin-top: 0;
		}
		.mui-table h4{
			line-height: 21px;
			font-weight: 500;
		}

		#dateValue, #nameText{
			height: 30px;
			text-align: center;
			border: 1px solid #bbbbbb;
			border-radius: 2px 0 0 2px;
			margin: 5px -6px 5px 0;
		}

		#dateValue {
			width: 60%;
		}

		#nameText {
			width: 35%;
		}

		.cbutton{
			height: 30px;
			margin: 5px 0 5px 0;
			border-radius: 0 2px 2px 0;
			border-color: #bbbbbb;
		}

		.mui-col-xs-4 input {
			width: 50%;
			height: 35px;
			margin: 0px;
			padding-left: 5px;
		}
	</style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
	<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	<h1 class="mui-title">辅助物品添加</h1>
</header>
<div class="mui-content">
	<form name="auxForm" action="auxiliaryAdd.do">
		<div class="mui-table">
			<div class="mui-table-cell mui-col-xs-6" style="padding-left: 15px;vertical-align: middle;">
				<input id="dateValue" type="text" readonly="readonly"/>
				<button id="showDate" class="cbutton" type="button" data-options='{"type":"date","beginYear":2019,"endYear":2022}'>选择日期</button>
			</div>
			<div class="mui-table-cell mui-col-xs-2" style="vertical-align: middle;text-align: right;padding-right: 10px;">
				<button id="addElement" type="button">+</button>
				<button id="delElement" type="button">-</button>
			</div>
		</div>
		<ul id="list" class="mui-table-view mui-table-view-striped">
			<li class="mui-table-view-cell">
				<div class="mui-table">
					<div class="mui-table-cell mui-col-xs-8">
						<label>物品：</label>
						<input id="nameText" type="text" readonly>
						<button class="cbutton" type="button">选择</button>
						<input type="hidden" name="nameValue"/>
					</div>
				</div>
				<div class="mui-table">
					<div class="mui-table-cell mui-col-xs-8">
						<label>数量：</label>
						<div class="mui-numbox">
							<button class="mui-btn mui-btn-numbox-minus" type="button">-</button>
							<input class="mui-input-numbox" type="number" name="qty"/>
							<button class="mui-btn mui-btn-numbox-plus" type="button">+</button>
						</div>
					</div>
					<div class="mui-table-cell mui-col-xs-4">
						<label>价格：</label>
						<input type="text" name="price">
					</div>
				</div>
			</li>
		</ul>
		<div class="mui-button-row">
			<button id="confirm" type="button" class="mui-btn mui-btn-primary">确认</button>&nbsp;&nbsp;
			<button type="button" class="mui-btn mui-btn-danger">取消</button>
		</div>
	</form>
</div>
</body>
<script src="js/comm.js"></script>
<script src="js/mui.min.js"></script>
<script src="js/mui.picker.min.js"></script>
<script src="js/mui.poppicker.js"></script>
<script>
	(function($, doc) {
		$.init({
			swipeBack: true //启用右滑关闭功能
		});

		//动态添加物品信息
		let divHtml =
				'<div class="mui-table"><div class="mui-table-cell mui-col-xs-8">'+
				'<label>物品：</label><input id="nameText" type="text" readonly>'+
				'<button class="cbutton" type="button">选择</button>'+
				'<input type="hidden" name="nameValue"/></div></div>'+
				'<div class="mui-table"><div class="mui-table-cell mui-col-xs-8">'+
				'<label>数量：</label>'+
				'<div class="mui-numbox">'+
				'<button class="mui-btn mui-btn-numbox-minus" type="button">-</button>'+
				'<input class="mui-input-numbox" type="number" name="qty"/>'+
				'<button class="mui-btn mui-btn-numbox-plus" type="button">+</button>'+
				'</div></div><div class="mui-table-cell mui-col-xs-4">'+
				'<label>价格：</label><input type="text" name="price"></div></div>';
		let plusButton = doc.getElementById('addElement');
		plusButton.addEventListener('tap', function(event) {
			let ul,li,tab,col;
			ul = document.querySelector(".mui-table-view");
			li = document.createElement("li");
			li.innerHTML = divHtml;
			li.setAttribute("class", "mui-table-view-cell");
			ul.append(li);
		}, false);

		var nodeUl = doc.getElementById('list');
		// Options for the observer (which mutations to observe)
		var config = { attributes: true, childList: true, subtree: true };
		// Callback function to execute when mutations are observed
		var callback = function(mutationsList) {
			for(var mutation of mutationsList) {
				if (mutation.type == 'childList') {
					let div = mutation.addedNodes[0].querySelector(".mui-numbox");
					$('.mui-numbox').numbox();
					//div.numbox();
				}
			}
		};
		// Create an observer instance linked to the callback function
		var observer = new MutationObserver(callback);
		// Start observing the target node for configured mutations
		observer.observe(nodeUl, config);
		//-------------------------------------------------------

		//物品选择框
		var userPicker = new $.PopPicker();
		userPicker.setData(${data});

		mui('#list').on('tap','.cbutton', function() {
			let node = this;
			userPicker.show(function(items) {
				node.previousElementSibling.value = items[0].text;
				node.nextElementSibling.value = items[0].value;
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);
		//------------------------------------------------------

		//日期选择框
		var result = doc.getElementById("dateValue");
		result.value = new Date().Format("yyyy-MM-dd");
		var btn = doc.getElementById("showDate");
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


		$('#confirm')[0].addEventListener('tap', function() {
			let array = doc.getElementsByName("nameValue");
			for(let i = 0,len=array.length; i < len; i++) {
				if(!validate.isEmpty(array[i].value)) {
					mui.toast('名称不能为空！');
					return;
				}
			}

			array = doc.getElementsByName("qty");
			for(let i = 0,len=array.length; i < len; i++) {
				if(array[i].value <= 0 ) {
					mui.toast('数量必须大于0！');
					return;
				}
			}

			array = doc.getElementsByName("price");
			for(let i = 0,len=array.length; i < len; i++) {
				if(!validate.isNumber(array[i].value)) {
					mui.toast('金额不能为空或必须为数字！');
					return;
				}
			}
			mui('form')[0].submit();
		});

	})(mui, document);
</script>
</html>