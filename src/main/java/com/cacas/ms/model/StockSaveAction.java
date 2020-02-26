package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.StockDao;
import com.cacas.ms.dao.po.GoodsPO;
import com.cacas.ms.dao.po.StockPO;
import com.cacas.ms.tools.Constant.OpType;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 确认添加的物品信息
 */
@Slf4j
public class StockSaveAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("type");
        String[] ids = request.getParameterValues("gid");
        String[] qtys = request.getParameterValues("qty");
        String[] prices = request.getParameterValues("price");
        String[] names = request.getParameterValues("gname");

        log.trace("确认添加的物品信息，参数：{},{},{},{},{}",type,ids,qtys,prices,names);
        request.setAttribute("opt",type);
        request.setAttribute("ids",ids);
        request.setAttribute("qtys",qtys);
        request.setAttribute("prices",prices);
        request.setAttribute("gnames",names);
        return "stockConfirm.jsp";
    }
}
