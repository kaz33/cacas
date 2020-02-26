package com.cacas.ms.view;

public class StockQueryVO {
    private int month;
    private int inSum;
    private int outSum;

    public StockQueryVO() {

    }

    public StockQueryVO(int month,int inSum,int outSum) {
        this.month = month;
        this.inSum = inSum;
        this.outSum = outSum;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getInSum() {
        return inSum;
    }

    public void setInSum(int inSum) {
        this.inSum = inSum;
    }

    public int getOutSum() {
        return outSum;
    }

    public void setOutSum(int outSum) {
        this.outSum = outSum;
    }
}
