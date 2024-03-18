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
import model.Order;
import model.OrderDetails;

/**
 *
 * @author Admin
 */
public class OrderDetailsDAO {
    
    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();
    
    public boolean addOrderDetails(OrderDetails od) {
        
        String sql = """
                     INSERT INTO [dbo].[order_details]
                                ([order_id]
                                ,[num_model]
                                ,[amount]
                                ,[price]
                                ,[size])
                          VALUES (?, ?, ?, ?, ?)
                     """;
        
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, od.getOrderID());
            st.setInt(2, od.getNumModel());
            st.setInt(3, od.getQuantity());
            st.setDouble(4, od.getPrice());
            st.setInt(5, od.getSize());
            
            if (st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }
    
    public List<OrderDetails> getOrderDetailsByOid(int id) {
        String sql = """
                     SELECT [order_id]
                           ,[num_model]
                           ,[amount]
                           ,[price]
                           ,[size]
                       FROM [dbo].[order_details]
                       where order_id = ?
                     """;
        List<OrderDetails> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {                
                list.add(new OrderDetails(rs.getInt("order_id"),
                        rs.getInt("num_model"),
                        rs.getInt("amount"),
                        rs.getDouble("price"),
                        rs.getInt("size")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
}
