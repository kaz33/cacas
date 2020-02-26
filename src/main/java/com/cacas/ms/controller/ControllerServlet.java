package com.cacas.ms.controller;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.core.util.StatusPrinter;
import com.cacas.ms.tools.DBUtil;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Map;

@Slf4j
@WebServlet(name = "ControllerServlet")
public class ControllerServlet extends HttpServlet {
    Map<String,Action> actions = new Hashtable<String,Action>();
    DBUtil db = DBUtil.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log.trace("doGet方法");
        Connection conn =(Connection) getServletContext().getAttribute("connection");
        db.setConnection(conn);

        String url = request.getRequestURI().toString();
        log.debug("请求的url:{}",url);
        //解析URL得到key
        int startIndex = url.lastIndexOf("/")+1;
        int endIndex = url.indexOf(".do");
        url = url.substring(startIndex, endIndex);
        log.debug("key:{},values{}",url,actions);
        //通过Key取出controller对象
        Action controller = actions.get(url);
        //执行controller的execute方法
        String jspName = controller.execute(request, response);
        //判断是否是ajax请求
        if(!jspName.equals("async")) {
            request.getRequestDispatcher(jspName).forward(request,response);
        }

    }


    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        //获取初始化参数，初始化所有的controller对象

        log.trace("init方法");
        Enumeration<String> names = config.getInitParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            String className = config.getInitParameter(name);
            //利用反射创建对象
            try {
                Class<?> clazz = Class.forName(className);
                Action obj = (Action) clazz.newInstance();
                //将对象添加到集合中
                actions.put(name, obj);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
