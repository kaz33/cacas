package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.AmountDao;
import com.cacas.ms.view.AmountVO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 查询本年按月汇总的销售额，点击每个条目可以通过ajax查询每天详细的销售额
 */
@Slf4j
public class AmountQueryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("本年每月销售汇总");
        List<AmountVO> list = AmountDao.queryAmountByMonth();
        request.setAttribute("list",list);
        return "amountQuery.jsp";
    }
}
