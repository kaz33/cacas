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
 * 保存确认提交的物品出入库信息
 */
@Slf4j
public class StockConfirmAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("type").toUpperCase();
        String[] ids = request.getParameterValues("gid");
        String[] qtys = request.getParameterValues("qty");
        String remark = request.getParameter("remark");

        log.trace("保存物品出入库信息,参数:{},{},{},{}",type,ids,qtys,remark);
        List<GoodsPO> list = new ArrayList<GoodsPO>();
        StockPO stock = new StockPO(OpType.valueOf(type).ordinal(),remark);
        stock.setGoods(list);
        GoodsPO goods = null;
        for (int i = 0; i < ids.length; i++) {
            goods = new GoodsPO(Integer.parseInt(ids[i]),Integer.parseInt(qtys[i]));
            list.add(goods);
        }
        boolean result = StockDao.saveStock(stock);
        request.setAttribute("type",type);
        request.setAttribute("result",result);

        return "stockConfirm.jsp";
    }
}
