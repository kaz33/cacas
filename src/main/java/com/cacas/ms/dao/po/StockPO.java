package com.cacas.ms.dao.po;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

public class StockPO {
    private int sid;
    private List<GoodsPO> goods;
    private Timestamp dtime;
    private int inout;
    private String remark;

    public StockPO() {

    }

    public StockPO(int sid,Timestamp dtime,int inout,String remark) {
        this(inout,remark);
        this.sid = sid;
        this.dtime = dtime;
    }

    public StockPO(int inout,String remark) {
        this.inout = inout;
        this.remark = remark;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public List<GoodsPO> getGoods() {
        return goods;
    }

    public void setGoods(List<GoodsPO> goods) {
        this.goods = goods;
    }

    public String getDtime() {
        DateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
        return dt.format(dtime);
    }

    public void setDtime(Timestamp dtime) {
        this.dtime = dtime;
    }

    public int getInout() {
        return inout;
    }

    public void setInout(int inout) {
        this.inout = inout;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
