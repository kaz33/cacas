package com.cacas.ms.dao;

import com.cacas.ms.dao.po.GoodsPO;
import com.cacas.ms.dao.po.StockPO;
import com.cacas.ms.tools.DBUtil;
import com.cacas.ms.view.StockQueryVO;
import lombok.extern.slf4j.Slf4j;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.cacas.ms.tools.Constant.*;
@Slf4j
public class StockDao {
    private static DBUtil db = DBUtil.getInstance();

    /*
     *保存需要统计库存的物品出入库数据
     * @param po
     * @return
     */
    public static boolean saveStock(StockPO po) {
        return saveStock(po,IsStatis.YES);
    }

    /**
     * 是否需要统计库存，插入出入库信息表，主要材料需要统计库存，辅助材料不需要统计库存
     * @param po
     * @param isStatis
     * @return
     */
    public static boolean saveStock(StockPO po,IsStatis isStatis) {
        log.trace("保存stock表，是否是需要统计库存物品:{}",isStatis);
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        boolean result = false;
        try {
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(SQL_STOCK_INSERT, Statement.RETURN_GENERATED_KEYS);
            log.debug("sql:{},参数:{},{}",SQL_STOCK_INSERT,po.getInout(),po.getRemark());
            ps.setInt(1, po.getInout());
            ps.setObject(2, po.getRemark());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                po.setSid(rs.getInt("sid"));
            }

            switch (isStatis) {
                case YES:
                    saveStockGoods(po);
                    break;
                case NO:
                    saveStockGoodsNotStatis(po);
            }
            conn.commit();
            conn.setAutoCommit(true);
            result = true;
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }

    /**
     *需要库存统计的物品，插入物品_库存表
     */
    public static boolean saveStockGoods(StockPO stock) throws SQLException {
        log.trace("不需要库存统计的物品，插入物品_库存表");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        List<GoodsPO> list = stock.getGoods();
        boolean result = false;
        try {
            ps = conn.prepareStatement(SQL_STOCK_GOODS_INSERT);
            log.debug("sql:{}",SQL_STOCK_GOODS_INSERT);
            for (GoodsPO po : list) {
                int qty = po.getStockQty(); /*出or入库数量*/
                ps.setInt(1, stock.getSid());
                ps.setInt(2, po.getId());
                ps.setInt(3, qty);
                qty = stock.getInout() == 0 ? qty : qty*-1; /*判断是加库存量还是减库存量*/
                ps.setInt(4, qty);
                ps.setInt(5,po.getId());
                ps.addBatch();
                po.setStockQty(qty);
                //GoodsDao.updateByStockQty(po);
                // 这里不能更新goods表的库存数量，因为这时对stock_goods的插入操作还没有执行，
                // 插入stock_goods表需要读取goods库存信息
            }

            ps.executeBatch();

            for(GoodsPO po : list) {
                GoodsDao.updateByStockQty(po);
            }

            result = true;
        } catch (SQLException e) {
            throw e;
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }

    /**
     * 不需要库存统计的物品，插入物品_库存表
     * @param stock
     * @return 是否成功
     * @throws SQLException
     */
    public static boolean saveStockGoodsNotStatis(StockPO stock) throws SQLException {
        log.trace("不需要库存统计的物品，插入物品_库存表");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        List<GoodsPO> list = stock.getGoods();
        boolean result = false;
        try {
            ps = conn.prepareStatement(SQL_STOCK_GOODS_INSERT_NOT_STATIS);
            log.debug("sql:{}",SQL_STOCK_GOODS_INSERT_NOT_STATIS);
            for (GoodsPO po : list) {
                ps.setInt(1, stock.getSid());
                ps.setInt(2, po.getId());
                ps.setInt(3, po.getStockQty());
                ps.setDouble(4, po.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
            result = true;
        } catch (SQLException e) {
            throw e;
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }

    /**
     * 按月统计出库和入库数量
     * @return
     */
    public static List<StockQueryVO> queryStockSum() {
        log.trace("按月统计出库和入库数量");
        List<StockQueryVO> list = new ArrayList<StockQueryVO>();
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        StockQueryVO vo = null;
        try {
            ps = conn.prepareStatement(SQL_STOCK_QUERY_SUM);
            log.debug("sql:{}",SQL_STOCK_QUERY_SUM);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                vo = new StockQueryVO(rs.getInt("dt"),
                        rs.getInt("insum"),
                        rs.getInt("outsum"));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return list;
    }

    /**
     * 查询指定月的出库入库信息
     * @param mon
     * @return
     */
    public static List<StockPO> queryStockByMon(String mon) {
        log.trace("查询指定月的出库入库信息");
        List<StockPO> list = new ArrayList<StockPO>();
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        StockPO po = null;
        try {
            ps = conn.prepareStatement(SQL_STOCK_QUERY_BY_MON);
            log.debug("sql:{},参数:{}",SQL_STOCK_QUERY_BY_MON,mon);
            ps.setString(1,mon);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                po = new StockPO(rs.getInt("sid"),
                        rs.getTimestamp("dtime"),
                        rs.getInt("inout"),
                        rs.getString("remark"));
                list.add(po);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return list;
    }

    /**
     * 根据id查询stock表
     * @param id
     * @return
     */
    public static StockPO queryStockById(String id) {
        log.trace("根据id查询stock表");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        StockPO po = new StockPO();
        List<GoodsPO> list = new ArrayList<GoodsPO>();
        po.setGoods(list);
        GoodsPO go = null;
        try {
            ps = conn.prepareStatement(SQL_STOCK_QUERY_BY_ID);
            log.debug("sql:{},参数:{}",SQL_STOCK_QUERY_BY_ID,id);
            ps.setString(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if(rs.isFirst()) {
                    po.setDtime(rs.getTimestamp("dt"));
                    po.setInout(rs.getInt("opt"));
                    po.setRemark(rs.getString("remark"));
                }
                go = new GoodsPO(rs.getString("name"),
                        rs.getInt("qty"),
                        rs.getDouble("amount"),
                        /*goods对象没有余量字段,临时用statis字段代替,免得加字段*/
                        rs.getInt("surplus"));
                list.add(go);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return po;
    }
}
