package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.GoodsDao;
import com.cacas.ms.dao.po.GoodsPO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Slf4j
public class GoodsQueryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("物品查询");
        List<GoodsPO> po  = GoodsDao.queryAll();
        request.setAttribute("list",po);
        return "goodsList.jsp";
    }
}
