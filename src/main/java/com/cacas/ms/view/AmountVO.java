package com.cacas.ms.view;

/**
 * 销售模块界面显示对象
 */
public class AmountVO {
    private int month;
    private String maonthLabel;
    private int amount;

    public AmountVO() {

    }

    public AmountVO(int month, String maonthLabel, int amount) {
        this.month = month;
        this.maonthLabel = maonthLabel;
        this.amount = amount;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public String getMaonthLabel() {
        return maonthLabel;
    }

    public void setMaonthLabel(String maonthLabel) {
        this.maonthLabel = maonthLabel;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
