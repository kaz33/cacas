package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.StockDao;
import com.cacas.ms.dao.po.StockPO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 查询一笔出入库详细信息
 */
@Slf4j
public class StockQueryDetailAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        log.trace("根据id查询出入库详细信息，参数：{}",id);
        StockPO po = StockDao.queryStockById(id);
        request.setAttribute("stock",po);
        return "stockDetail.jsp";
    }
}
