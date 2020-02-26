package com.cacas.ms.dao;

import com.cacas.ms.tools.DBUtil;
import com.cacas.ms.view.QueryOutByMonVO;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.cacas.ms.tools.Constant.SQL_QUERY_OUT_BY_MON;

@Slf4j
public class QueryDao {
    private static DBUtil db = DBUtil.getInstance();

    /**
     * 根据输入月份，查询当月每种物品出库数量
     * @param month
     * @return
     */
    public static List<QueryOutByMonVO> queryOutByMon(int month) {
        log.trace("查询每种物品的出库数量,参数:{}",month);
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<QueryOutByMonVO> list = null;
        QueryOutByMonVO po = null;
        try {
            ps = conn.prepareStatement(SQL_QUERY_OUT_BY_MON);
            log.debug("slq:{}",SQL_QUERY_OUT_BY_MON);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            list = new ArrayList<QueryOutByMonVO>();
            while (rs.next()) {
                po = new QueryOutByMonVO(rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("qty"),
                        rs.getDouble("amount"));
                list.add(po);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(rs, ps);
        }
        return list;
    }

}
