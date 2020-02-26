package com.cacas.ms.view;

public class QueryOutByMonVO {
    String name;
    Double price;
    Integer qty;
    Double amount;

    public QueryOutByMonVO(String name, Double price, Integer qty, Double amount) {
        this.name = name;
        this.price = price;
        this.qty = qty;
        this.amount = amount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
}
