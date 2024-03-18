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
import model.Item;

/**
 *
 * @author Admin
 */
public class CartDAO {

    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();

    public void addToCart(Item i, Customer c) {
        String sql = """
                     INSERT INTO [dbo].[cart]
                                ([num_model]
                                ,[customer_id]
                                ,[amount]
                                ,[price]
                                ,[size])
                          VALUES(?, ?, ?, ?, ?)
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, i.getNumModel());
            st.setInt(2, c.getId());
            st.setInt(3, i.getAmount());
            st.setDouble(4, i.getPrice());
            st.setInt(5, i.getSize());

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateAmount(Item i, Customer c) {
        String sql = """
                     UPDATE [dbo].[cart]
                        SET[amount] = ?
                      WHERE num_model = ? and customer_id = ? and size = ?
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, i.getAmount());
            st.setInt(2, i.getNumModel());
            st.setInt(3, c.getId());
            st.setInt(4, i.getSize());

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void delete(Customer c, int numModel, int size) {
        String sql = """
                     DELETE FROM [dbo].[cart]
                           WHERE customer_id = ? and num_model = ? and size = ?
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, c.getId());
            st.setInt(2, numModel);
            st.setInt(3, size);

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<Item> getAllItem(Customer c) {
        String sql = """
                     select * from cart where customer_id = ?
                     """;
        List<Item> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, c.getId());
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Item(rs.getInt("num_model"),
                        rs.getInt("amount"),
                        rs.getDouble("price"),
                        rs.getInt("size")));
            }
            return list;
        } catch (SQLException e) {
        }

        return null;
    }

    public Item getItemBySizeAndId(Item i, Customer c) {
        String sql = """
                     select * from cart where customer_id = ? and num_model = ? and size = ?
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, c.getId());
            st.setInt(2, i.getNumModel());
            st.setInt(3, i.getSize());

            rs = st.executeQuery();
            if (rs.next()) {
                return new Item(rs.getInt("num_model"),
                        rs.getInt("amount"),
                        rs.getDouble("price"),
                        rs.getInt("size"));
            }
        } catch (SQLException e) {
        }
        
        return null;
    }
    
    public int deleteByCid(Customer c) {
        String sql = """
                     DELETE FROM [dbo].[cart]
                           WHERE customer_id = ?
                     """;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, c.getId());

            if (st.executeUpdate() > 0) {
                return 1;
            }
        } catch (SQLException e) {
        }
        
        return 0;
    }

}
