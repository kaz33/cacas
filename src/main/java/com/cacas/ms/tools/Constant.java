package com.cacas.ms.tools;

public interface Constant {
    //库存管理模块使用，表示操作类型
    enum OpType {IN, OUT}

    enum IsStatis {NO, YES}

    int PAGE_SIZE = 10;

    String SQL_AMOUNT_INSERT =
            "insert into sale(amount,dtime) values(?,?)";

    String SQL_AMOUNT_QUERYBYMONTH =
            "select mm, CONCAT(mm,'月'),sum(amount) from " +
                    "(select FORMATDATETIME(dtime,'yyyy-MM') dt,MONTH(dtime) mm,amount " +
                    "from sale " +
                    "where YEAR(dtime) = YEAR(CURDATE())) " +
                    "group by dt order by dt";

    String SQL_AMOUNT_QUERYDETAIL =
            "select dtime,amount from sale " +
                    "where YEAR(dtime) = YEAR(CURDATE()) and MONTH(dtime) = ? " +
                    "order by dtime";

    String SQL_GOODS_QUERYALL =
            "select gid, name, price, spec, unit, statis, stockqty, " +
                    "(select name from sysdict where sid = unit) unitname, " +
                    "count(1) over () cnt " +
                    "from goods ";

    String SQL_GOODS_WHERE_STOCK = "where statis=1";

    String SQL_GOODS_WHERE_AUX = "where statis=0";

    String SQL_GOODS_UPDATEFORSTOCK =
            "update goods set stockqty = stockqty + ? WHERE gid = ?";

    String SQL_STOCK_INSERT =
            "insert into stock(dtime,inout,remark) values(SYSDATE,?,?)";

    String SQL_STOCK_GOODS_INSERT =
            "insert into stock_goods(sid,gid,qty,surplus) " +
                    "values(?,?,?,select stockqty + ? from goods where gid = ?)";

    String SQL_STOCK_GOODS_INSERT_NOT_STATIS =
            "insert into stock_goods(sid,gid,qty,price) values(?,?,?,?)";

    String SQL_STOCK_QUERY_SUM =
            "select dt, sum(insum) insum, sum(outsum) outsum from ( " +
                    "select dt,inout, " +
                    "CASEWHEN(inout = 0, sum(qty * price), 0) insum, " +
                    "CASEWHEN(inout = 1, sum(qty * price), 0) outsum from ( " +
                    "select MONTH(dtime) dt, inout, qty, " +
                    "CASEWHEN(sg.price is not null, sg.price, g.price) price " +
                    "from stock s, STOCK_GOODS sg, goods g " +
                    "where s.SID = sg.SID and g.GID = sg.GID and YEAR(CURDATE()) = YEAR(dtime)) " +
                    "group by dt, inout) " +
                    "group by dt order by dt";

    String SQL_STOCK_QUERY_BY_MON =
            "select * from stock where YEAR(CURDATE()) = YEAR(dtime) and MONTH(dtime) = ? order by dtime";

    String SQL_STOCK_QUERY_BY_ID =
            "select s.dtime dt,s.inout opt,name,qty , " +
                    "CASEWHEN(sg.price is not null,sg.price,g.price)*qty amount, " +
                    "surplus,remark " +
                    "from goods g,stock_goods sg,stock s " +
                    "where g.gid = sg.gid and sg.sid = s.sid and " +
                    "s.sid = ?";

    String SQL_GOODS_INSERT =
            "insert into goods(name,price,spec,unit,statis,stockQty) " +
                    "values(?,?,?,?,?,?)";

    String SQL_QUERY_OUT_BY_MON =
            "select name, CASEWHEN(statis = 1, g.price, 0) price, sum(qty) qty, " +
                    "sum(CASEWHEN(statis = 1, g.price, sg.price) * sg.qty) amount " +
                    "from goods g,stock_goods sg,stock s " +
                    "where g.gid = sg.gid and sg.sid = s.sid and " +
                    "YEAR(dtime) = YEAR(CURDATE()) and MONTH(dtime) = ? " +
                    "and s.inout = 1 group by g.gid,g.price";
}
