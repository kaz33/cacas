package com.cacas.ms.model;

import com.cacas.ms.controller.Action;
import com.cacas.ms.dao.GoodsDao;
import com.cacas.ms.dao.po.GoodsPO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.cacas.ms.tools.Constant.PAGE_SIZE;

@Slf4j
public class GoodsQueryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String str = request.getParameter("page");
        log.trace("物品查询，参数:{}",str);
        int page;
        if(str ==null || str.length() == 0) {
            page = 0;
        } else {
            page = Integer.parseInt(str);
        }
        List<GoodsPO> po  = GoodsDao.queryAllByPage(page);
        int totalCount = po.get(0).getStatis();//获得总记录数
        int pageCount = (totalCount + PAGE_SIZE - 1) / PAGE_SIZE;//计算页数
        log.debug("总记录数:{}条,总页数:{}页,当前页:{}页",totalCount,pageCount,page);
        request.setAttribute("list",po);
        request.setAttribute("pageCount",pageCount);
        request.setAttribute("page",page);
        return "goodsList.jsp";
    }
}
