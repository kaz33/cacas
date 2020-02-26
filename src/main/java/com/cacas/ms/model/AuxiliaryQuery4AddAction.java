package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.GoodsDao;
import com.cacas.ms.dao.po.GoodsPO;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.cacas.ms.tools.Constant.SQL_GOODS_WHERE_AUX;

/**
 * 获取辅助物品添加页面，下拉菜单数据
 */
@Slf4j
public class AuxiliaryQuery4AddAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        log.trace("获取辅助物品添加页面，下拉菜单数据");
        List<GoodsPO> list = GoodsDao.queryByStockType(SQL_GOODS_WHERE_AUX);
        String str = new Gson().toJson(list);
        str = str.replaceAll("id","value").
                replaceAll("name","text");
        log.debug(str);
        request.setAttribute("data",str);
        return "auxiliaryAdd.jsp";
    }
}
