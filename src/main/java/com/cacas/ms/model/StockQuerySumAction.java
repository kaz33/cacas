package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.StockDao;
import com.cacas.ms.view.StockQueryVO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 查询按月汇总的出入库信息
 */
@Slf4j
public class StockQuerySumAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("查询按月汇总的出入库信息");
        List<StockQueryVO> list = StockDao.queryStockSum();
        request.setAttribute("list",list);
        return "stockQuery.jsp";
    }
}
