/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Order;

/**
 *
 * @author Admin
 */
public class OrderDAO {

    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();

    public int addOrder(Order o) {

        String sql = """
                     INSERT INTO [dbo].[orders]
                                ([customer_id]
                                ,[address]
                                ,[order_date]
                                ,[status])
                          VALUES (?, ?, ?, ?)
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, o.getCustomerID());
            st.setString(2, o.getAddress());
            st.setString(3, o.getOrderDate());
            st.setString(4, o.getStatus());

            if (st.executeUpdate() > 0) {
                return 1;
            }

        } catch (SQLException e) {
            return 0;
        }
        return 0;
    }

    public Order getOrderByOid(int orderID) {
        String sql = """
                     select * from orders where order_id = ?
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, orderID);
            rs = st.executeQuery();
            if (rs.next()) {
                return new Order(rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getString("address"),
                        rs.getString("order_date"),
                        rs.getString("status"));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Order> getOrderByCid(Customer c) {
        String sql = """
                     select * from orders where customer_id = ?
                     """;
        List<Order> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, c.getId());
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getString("address"),
                        rs.getString("order_date"),
                        rs.getString("status")));
            }
        } catch (SQLException e) {
        }

        return list;
    }

    public Order getNewestOrder() {
        String sql = """
                     select top 1 * from orders order by order_id desc
                     """;

        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            if (rs.next()) {
                return new Order(rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getString("address"),
                        rs.getString("order_date"),
                        rs.getString("status"));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Order> getOrderByStatus(String status) {
        String sql = """
                     select * from orders where status = ?
                     """;
        List<Order> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, status);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getString("address"),
                        rs.getString("order_date"),
                        rs.getString("status")));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public int deleteOrder(int id) {

        String sql = "delete orders where order_id = ?";

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            if (st.executeUpdate() > 0) {
                return 1;
            }
        } catch (SQLException e) {
            return 0;
        }
        return 0;
    }
    
    public boolean updateStatus(Order o) {
        String sql = """
                     UPDATE [dbo].[orders]
                        SET [status] = ?
                      WHERE order_id = ?
                     """;
        
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, o.getStatus());
            st.setInt(2, o.getOrderID());
            
            if (st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
        }
        
        return false;
    }

}
