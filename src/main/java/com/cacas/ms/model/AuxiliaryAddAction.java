package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.StockDao;
import com.cacas.ms.dao.po.GoodsPO;
import com.cacas.ms.dao.po.StockPO;
import com.cacas.ms.tools.Constant.OpType;
import com.cacas.ms.tools.Constant.IsStatis;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 辅助材料添加
 */
@Slf4j
public class AuxiliaryAddAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("nameValue");
        String[] qtys = request.getParameterValues("qty");
        String[] prices = request.getParameterValues("price");

        log.trace("辅助材料添加,参数:{},{},{}",ids,qtys,prices);
        List<GoodsPO> list = new ArrayList<GoodsPO>();
        StockPO stock = new StockPO();
        stock.setInout(OpType.OUT.ordinal());
        stock.setGoods(list);
        GoodsPO goods = null;
        for (int i = 0; i < ids.length; i++) {
            goods = new GoodsPO();
            goods.setId(Integer.parseInt(ids[i]));
            goods.setStockQty(Integer.parseInt(qtys[i]));
            goods.setPrice(Double.parseDouble(prices[i]));
            list.add(goods);
        }
        boolean result = StockDao.saveStock(stock, IsStatis.NO);
        request.setAttribute("result",result);

        return "auxiliaryAdd.jsp";
    }
}
