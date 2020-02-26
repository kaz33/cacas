package com.cacas.ms.dao;

import com.cacas.ms.dao.po.AmountPO;
import com.cacas.ms.tools.DBUtil;
import com.cacas.ms.view.AmountVO;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.cacas.ms.tools.Constant.*;

/**
 * 销售模块数据持久层
 */
@Slf4j
public class AmountDao {
    private static DBUtil db = DBUtil.getInstance();

    /**
     * 保存销售记录
     * @param po
     * @return 是否成功
     */
    public static boolean saveAmountRecord(AmountPO po) {
        log.trace("保存销售记录");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        boolean result = false;
        try {
            ps = conn.prepareStatement(SQL_AMOUNT_INSERT);
            log.debug("sql:{},参数:{},{}",SQL_AMOUNT_INSERT,po.getAmount(),po.getDtTime());
            ps.setInt(1,po.getAmount());
            ps.setDate(2,po.getDtTime());
            ps.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(ps);
        }
        return result;
    }

    /**
     * 按月统计销售额
     * @return
     */
    public static List<AmountVO> queryAmountByMonth() {
        log.trace("按月统计销售额");
        log.debug(SQL_AMOUNT_QUERYBYMONTH);
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<AmountVO> list = null;
        AmountVO vo = null;
        try {
            ps = conn.prepareStatement(SQL_AMOUNT_QUERYBYMONTH);
            rs = ps.executeQuery();
            list = new ArrayList<AmountVO>();
            while (rs.next()) {
                vo = new AmountVO(rs.getInt(1),rs.getString(2),rs.getInt(3));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(rs,ps);
        }
        return list;
    }

    /**
     * 查询指定月的销售金额
     * @param month 指定月
     * @return
     */
    public static List<AmountVO> queryAmountDetail(String month) {
        log.trace("查询指定月的销售金额");
        Connection conn = db.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<AmountVO> list = null;
        AmountVO vo = null;
        try {
            ps = conn.prepareStatement(SQL_AMOUNT_QUERYDETAIL);
            log.trace("sql:{},参数:{}",SQL_AMOUNT_QUERYDETAIL,month);
            ps.setInt(1,Integer.parseInt(month));
            rs = ps.executeQuery();
            list = new ArrayList<AmountVO>();
            while (rs.next()) {
                vo = new AmountVO();
                vo.setMaonthLabel(rs.getString(1));
                vo.setAmount(rs.getInt(2));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(rs,ps);
        }
        return list;
    }
}
