package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.StockDao;
import com.cacas.ms.dao.po.StockPO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Ajax请求每月的出入库情况
 */
@Slf4j
public class StockQueryByMonAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String month = request.getParameter("month");
        log.trace("查询指定月的出入库详细，参数：{}",month);
        List<StockPO> list = StockDao.queryStockByMon(month);
        Gson gson = new GsonBuilder().setDateFormat("MM-dd HH:mm").create();
        String str = gson.toJson(list);
        System.out.println(str);
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
