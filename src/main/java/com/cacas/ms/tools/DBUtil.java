package com.cacas.ms.tools;

import com.cacas.ms.dao.po.GoodsPO;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.Properties;

public class DBUtil {
    private Connection conn = null;
    private static DBUtil dbUtilSingle = null;

    private DBUtil() {
    }

    public static DBUtil getInstance() {
        if (dbUtilSingle == null) {
            // 给类加锁 防止线程并发
            synchronized (DBUtil.class) {
                if (dbUtilSingle == null) {
                    dbUtilSingle = new DBUtil();
                }
            }
        }
        return dbUtilSingle;
    }

    // 获得连接
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public Connection getConnection() {
        return this.conn;
    }

    // 关闭连接
    public void closeConnection(ResultSet rs, Statement statement) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void closeConnection(Statement statement) {
        try {
            if (statement != null) {
                statement.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInsertSql(Object obj,String tableName) {
        Class clazz = obj.getClass();
        Field[] strs = clazz.getDeclaredFields();
        StringBuffer sql = new StringBuffer();
        StringBuffer val = new StringBuffer();
        sql.append("intsert into ").append(tableName).append("(");
        val.append('(');
        String protype = null;
        for(Field field : strs) {
            protype = field.getName();
            Class type = field.getType();
            String methodName = "get"+Character.toUpperCase(protype.charAt(0))+protype.substring(1);
            Method method = null;
            try {
                method = clazz.getDeclaredMethod(methodName,null);
                Object value = method.invoke(obj,null);
                if(value != null){
                    if(type == int.class && ((Integer)value) <0) {
                        continue;
                    }
                    /*这里还可以扩展其它类型，形成通用的方法*/
                    sql.append(protype).append(",");
                    val.append("?").append(",");
                }
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        sql.deleteCharAt(sql.length()-1).append(")").append(" values").
                append(val.deleteCharAt(val.length()-1).append(")"));

        return sql.toString();
    }

    public static void main(String[] args) {
        Properties props = System.getProperties();
        props.list(System.out);
    }
}
