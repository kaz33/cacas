package com.cacas.ms.dao.po;

public class GoodsPO {
    private Integer id;
    private String name;
    private Double price;
    private String spec;
    private Integer unit;
    private Integer statis;
    private Integer stockQty;

    public GoodsPO() {

    }

    public GoodsPO(Integer id,String name) {
        this.id = id;
        this.name = name;
    }

    public GoodsPO(Integer id,Integer qty) {
        this.id = id;
        this.stockQty = qty;
    }

    public GoodsPO(String name,Integer qty,Double price,Integer type) {
        this.name = name;
        this.price = price;
        this.stockQty = qty;
        this.statis = type;
    }

    public GoodsPO(Integer id, String name, Double price, String spec, Integer unit, Integer type, Integer stockQty) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.spec = spec;
        this.unit = unit;
        this.statis = type;
        this.stockQty = stockQty;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public Integer getUnit() {
        return unit;
    }

    public void setUnit(Integer unit) {
        this.unit = unit;
    }

    public Integer getStatis() {
        return statis;
    }

    public void setStatis(Integer statis) {
        this.statis = statis;
    }

    public Integer getStockQty() {
        return stockQty;
    }

    public void setStockQty(Integer stockQty) {
        this.stockQty = stockQty;
    }

    public String getSaveSql() {

        return null;
    }
}
