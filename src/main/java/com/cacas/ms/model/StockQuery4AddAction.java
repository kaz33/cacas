package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.GoodsDao;
import com.cacas.ms.dao.po.GoodsPO;
import com.cacas.ms.tools.Constant.OpType;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;

import static com.cacas.ms.tools.Constant.SQL_GOODS_WHERE_STOCK;

/*
* 物品信息查询
* 出入库显示页面，库存查询页面
* optType：0入库、1出库
*/
@Slf4j
public class StockQuery4AddAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("物品信息查询");
        String type = request.getParameter("optType").toUpperCase();
        List<GoodsPO> list = GoodsDao.queryByStockType(SQL_GOODS_WHERE_STOCK);
        request.setAttribute("list",list);
        switch (OpType.valueOf(type)) {
            case IN:
                request.setAttribute("type",OpType.IN);
                break;
            case OUT:
                request.setAttribute("type",OpType.OUT);
        }
        return "stockAdd.jsp";
    }
}
