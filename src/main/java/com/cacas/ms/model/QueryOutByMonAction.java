package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.QueryDao;
import com.cacas.ms.view.QueryOutByMonVO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.List;

/**
 * 查询每个月出库详细
 */
@Slf4j
public class QueryOutByMonAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("查询每个月出库详细");
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH)+1;
        List<QueryOutByMonVO> list = QueryDao.queryOutByMon(month);
        request.setAttribute("list",list);
        return "queryOutByMon.jsp";
    }
}
