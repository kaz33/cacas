package com.cacas.ms.dao;

import com.cacas.ms.dao.po.GoodsPO;
import com.cacas.ms.tools.DBUtil;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.cacas.ms.tools.Constant.*;

@Slf4j
public class GoodsDao {
    private static DBUtil db = DBUtil.getInstance();

    public static List<GoodsPO> queryAllByPage(int page) {
        StringBuffer str = new StringBuffer();
        str.append("OFFSET ").append(page*PAGE_SIZE).append(" FETCH NEXT ").append(PAGE_SIZE).append(" ROWS ONLY");
        return queryByStockType(str.toString());
    }

    /**
     * 添加物品出入库信息时要先查询物品表
     * @param condition 为空表示查询所有物品，不为空表示是否是需要统计库存的物品
     * @return
     */
    public static List<GoodsPO> queryByStockType(String condition) {
        log.trace("根据条件查询物品列表，条件为：{}",condition);
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<GoodsPO> list = null;
        GoodsPO po = null;
        try {
            ps = conn.prepareStatement(SQL_GOODS_QUERYALL + condition);
            log.debug("sql:{}{}",SQL_GOODS_QUERYALL,condition);
            rs = ps.executeQuery();
            list = new ArrayList<GoodsPO>();
            while (rs.next()) {
                if(condition.indexOf("=0")>0) {
                    po = new GoodsPO(rs.getInt("gid"),
                            rs.getString("name"));
                } else {
                    po = new GoodsPO(rs.getInt("gid"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            //TODO 这里应该是spec字段，但是目前没有用，就借用单位字段
                            rs.getString("unitName"),
                            rs.getInt("unit"),
                            //TODO 这里应该是statis字段，但是目前没用，就借用分页查询总数
                            rs.getInt("cnt"),
                            rs.getInt("stockqty"));
                }
                list.add(po);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(rs, ps);
        }
        return list;
    }

    /**
     * 更新物品表的库存数量字段
     * @param po
     * @return
     * @throws SQLException
     */
    public static boolean updateByStockQty(GoodsPO po) throws SQLException{
        log.trace("更新物品表的库存数量字段");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        boolean result = false;
        try {
            ps = conn.prepareStatement(SQL_GOODS_UPDATEFORSTOCK);
            log.debug("sql:{},参数:{},{}",SQL_GOODS_UPDATEFORSTOCK,po.getStockQty(),po.getId());
            ps.setInt(1,po.getStockQty());
            ps.setInt(2,po.getId());
            ps.executeUpdate();
            result = true;
        } catch (SQLException e) {
            throw e;
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }

    /**
     * 保存物品
     * @param po
     * @return
     */
    public static boolean saveGoods(GoodsPO po) {
        log.trace("保存物品");
        boolean result = false;
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(SQL_GOODS_INSERT);
            ps.setObject(1,po.getName());
            ps.setObject(2,po.getPrice());
            ps.setObject(3,po.getSpec());
            ps.setObject(4,po.getUnit());
            ps.setObject(5,po.getStatis());
            ps.setInt(6,po.getStockQty());
            ps.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }
}
