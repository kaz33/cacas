package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.GoodsDao;
import com.cacas.ms.dao.po.GoodsPO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 添加物品
 */
@Slf4j
public class GoodsAddAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("gname");
        String price = request.getParameter("price");
        String spec = request.getParameter("spec");
        String unit = request.getParameter("unit");
        String statis = request.getParameter("statis");
        log.trace("添加物品，参数:{},{},{},{},{}",name,price,spec,unit,statis);
        GoodsPO po = new GoodsPO();
        po.setName(name);
        po.setPrice(Double.parseDouble(price));
        po.setStatis(Integer.parseInt(statis));
        po.setStockQty(0);
        if(spec.length()>0) {
            po.setSpec(spec);
        }
        if(unit.length()>0) {
            po.setUnit(Integer.parseInt(unit));
        }
        boolean result = GoodsDao.saveGoods(po);
        request.setAttribute("result",result);
        return "goodsAdd.jsp";
    }
}
