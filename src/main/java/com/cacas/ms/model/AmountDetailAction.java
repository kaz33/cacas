package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.AmountDao;
import com.cacas.ms.view.AmountVO;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * 查询指定月的每日销售金额
 * 接受ajax请求
 */
@Slf4j
public class AmountDetailAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String month = request.getParameter("month");

        log.trace("查询指定月的每日销售金额,参数:{}",month);
        List<AmountVO> list = AmountDao.queryAmountDetail(month);
        String str = new Gson().toJson(list);
        log.debug(str);
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");// 注意設置為utf-8否則前端接收到的中文為亂碼
        try {
            PrintWriter out = response.getWriter();
            // 返回給前端
            out.write(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "async";
    }
}
