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
			<div class="mui-content-padded" style="text-align: center">
				<ul class="mui-pagination">
					<li class='mui-previous <c:if test="${page==0}">mui-disabled</c:if>'>
						<a href="#">
							&laquo;
						</a>
					</li>
					<c:forEach begin="0" end="${pageCount-1}" varStatus="s">
					<li <c:if test="${s.index==page}">class="mui-active"</c:if>>
						<a href="goodsQuery.do?page=${s.index}">
							${s.index+1}
						</a>
					</li>
					</c:forEach>
					<li class='mui-next <c:if test="${page==(pageCount-1)}">mui-disabled</c:if>'>
						<a href="#">
							&raquo;
						</a>
					</li>
				</ul>
			</div>
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
		mui.init({
			swipeBack:true //启用右滑关闭功能
		});

		initSideMenu(mui,document);

		(function($) {
			$('.mui-pagination').on('tap', 'a', function() {
				var li = this.parentNode;
				var classList = li.classList;
				if (!classList.contains('mui-active') && !classList.contains('mui-disabled')) {
					var active = li.parentNode.querySelector('.mui-active');
					if (classList.contains('mui-previous')) {//previous
						if (active) {
							var previous = active.previousElementSibling;
							console.log('previous', previous);
							if (previous && !previous.classList.contains('mui-previous')) {
								$.trigger(previous.querySelector('a'), 'tap');
							}
						}
					} else if (classList.contains('mui-next')) {//next
						if (active) {
							var next = active.nextElementSibling;
							console.log('next', next);
							if (next && !next.classList.contains('mui-next')) {
								$.trigger(next.querySelector('a'), 'tap');
							}
						}
					} else {//page
						console.log('page',active);
						location.href = this.getAttribute('href');
					}
				}
			});
		})(mui);
	</script>
</html>