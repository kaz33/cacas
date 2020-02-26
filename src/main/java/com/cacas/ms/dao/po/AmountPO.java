package com.cacas.ms.dao.po;

import com.cacas.ms.tools.DBUtil;

import java.sql.Date;

public class AmountPO {
    private int amount;
    private Date dtTime;

    public AmountPO() {

    }

    public AmountPO(String amount,String dtime) {
        this.amount = Integer.parseInt(amount);
        this.dtTime = Date.valueOf(dtime);
    }
    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getDtTime() {
        return dtTime;
    }

    public void setDtTime(String time) {
        this.dtTime = Date.valueOf(time);
    }

}
