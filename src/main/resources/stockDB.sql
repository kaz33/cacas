/*物品表*/
CREATE TABLE
    GOODS
(
    gid      int auto_increment,
    name     VARCHAR(20),
    price    double,         --单价
    spec     VARCHAR(10), --规格
    unit     int,         --单位
    statis   int,         --是否需要统计库存,0不统计,1统计
    stockQty int,         --当前库存
    PRIMARY KEY (GID)
);

/*销售*/
CREATE TABLE
    sale
(
    sid    int auto_increment,
    dtime  DATE,
    amount int,
    PRIMARY KEY (sid)
);

CREATE TABLE
    stock
(
    sid    int auto_increment,
    dtime  TIMESTAMP,
    inout  int,          --出库0,入库1
    remark VARCHAR(100), --备注
    PRIMARY KEY (sid)
);

CREATE TABLE
    stock_goods
(
    sgid int auto_increment,
    sid  int,
    gid  int,
    qty  int, --数量
    unit int, --单位
    price double,--价格 只有价格浮动的辅助材料需要使用这个字段，如鸡蛋和油
    surplus int,
    PRIMARY KEY (sgid),
    CONSTRAINT stock_goods_fk1 FOREIGN KEY (gid) REFERENCES GOODS ("GID"),
    CONSTRAINT stock_goods_fk2 FOREIGN KEY (sid) REFERENCES stock ("SID")
);

create table sysdict
(
    sid int,
    name varchar(6) not null,
    primary key (sid)
);


delete from stock_goods;
delete from stock;
delete from goods;
delete from sale;
ALTER SEQUENCE SYSTEM_SEQUENCE_2FA1E384_5C92_4D99_88E7_2EF51F0737DF RESTART WITH 1;
ALTER SEQUENCE SYSTEM_SEQUENCE_85EB37D4_1C2B_4D81_A3DE_1DB19063BCE7 RESTART WITH 1;
ALTER SEQUENCE SYSTEM_SEQUENCE_A821FE3C_B046_4D78_A89D_74504533ADF3 RESTART WITH 1;
ALTER SEQUENCE SYSTEM_SEQUENCE_D77D0F93_D5EC_4E62_BA23_D8E839F474BF RESTART WITH 1;

INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('章鱼肉', 90, '1kg', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('章鱼粉', 28.9, '3kg', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('海苔', 76.5, '500g', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('柴鱼', 59.5, '500g', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('皮皮虾', 38.25, '500g', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('哈哈鱼', 38.25, '500g', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('蒜香酱', 38.25, '2000cc', 1, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('香辣酱', 38.25, '2000cc', 1, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('沙拉酱', 17, '1kg', 0, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('打包袋', 5, '50个', 2, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('船盒', 345, '1500', 2, 1, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('金丝肉松', 47, '2.5kg', 0, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('芝士碎', 485, '12kg', 0, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('培根', 69, '2kg', 0, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('青虾', 25, '200g', 0, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('冻玉米', 9, null, 0, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('鸡蛋', 200, '360g', 4, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('油', 38, '5L', 1, 0, 0);
INSERT INTO PUBLIC.GOODS (NAME, PRICE, SPEC, UNIT, STATIS, STOCKQTY) VALUES ('卷心菜', 2, null, null, 0, 0);
INSERT INTO PUBLIC.SYSDICT (SID, NAME) VALUES (0, '袋');
INSERT INTO PUBLIC.SYSDICT (SID, NAME) VALUES (1, '瓶');
INSERT INTO PUBLIC.SYSDICT (SID, NAME) VALUES (2, '捆');
INSERT INTO PUBLIC.SYSDICT (SID, NAME) VALUES (3, '个');
INSERT INTO PUBLIC.SYSDICT (SID, NAME) VALUES (4, '箱');
/*
select dt, sum(insum) insum, sum(outsum) outsum
from (
    select dt,
        inout,
        CASEWHEN(inout = 0, sum(qty * price), 0) insum,
        CASEWHEN(inout = 1, sum(qty * price), 0) outsum
    from (
        select MONTH(dtime) dt, inout, qty, price
        from stock s,
             STOCK_GOODS sg,
             goods g
        where s.SID = sg.SID
          and g.GID = sg.GID
          and YEAR(CURDATE()) = YEAR(dtime))
    group by dt, inout)
group by dt
order by dt;
 */