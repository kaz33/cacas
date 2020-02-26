package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.AmountDao;
import com.cacas.ms.dao.po.AmountPO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 每天销售记录
 */
@Slf4j
public class AmountRecordAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String amount = request.getParameter("amount");
        String dateStr = request.getParameter("datetime");

        log.trace("记录销售,参数:{},{}",amount,dateStr);
        AmountPO po = new AmountPO(amount,dateStr);
        boolean result = AmountDao.saveAmountRecord(po);
        request.setAttribute("result", result);
        return "amountRecord.jsp";
    }
}
