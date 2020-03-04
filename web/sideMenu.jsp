<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!--侧滑菜单部分-->
    <aside id="offCanvasSide" class="mui-off-canvas-right">
        <div id="offCanvasSideScroll" class="mui-scroll-wrapper">
            <div class="mui-scroll">
                <p style="margin: 10px 15px;">
                    <button id="offCanvasHide" type="button" class="mui-btn mui-btn-danger mui-btn-block"
                            style="padding: 5px 20px;">关闭侧滑菜单
                    </button>
                </p>
                <ul class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
                    <li class="mui-table-view-cell">
                        <a class="mui-navigate-right" href="index.jsp?type=goods">
                            物料管理
                        </a>
                    </li>
                    <li class="mui-table-view-cell">
                        <a class="mui-navigate-right" href="index.jsp?type=sale">
                            销售管理
                        </a>
                    </li>
                    <li class="mui-table-view-cell">
                        <a class="mui-navigate-right" href="index.jsp?type=stock">
                            库存管理
                        </a>
                    </li>
                    <li class="mui-table-view-cell">
                        <a class="mui-navigate-right" href="index.jsp?type=query">
                            报表查询
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </aside>
