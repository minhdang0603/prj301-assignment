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

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    
    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();
    
    public Customer getCustomerByEmail(String email) {
        String sql = "select * from customer where email = ?";
        Customer c = null;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, email);
            rs = st.executeQuery();
            if (rs.next()) {
                c = new Customer(rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("password"));
            }
        } catch (SQLException e) {
        }
        return c;
    }
    
    public Customer getCustomerByEmailAndPassword(String email, String password) {
        String sql = "select * from customer where email = ? and password = ?";
        Customer c = null;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            rs = st.executeQuery();
            if (rs.next()) {
                c = new Customer(rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("email"),
                        rs.getString("password"));
            }
        } catch (SQLException e) {
        }
        return c;
    }
    
    public boolean signup(Customer c) {
        String sql = "INSERT INTO [dbo].[customer]\n"
                + "           ([first_name]\n"
                + "           ,[last_name]\n"
                + "           ,[email]\n"
                + "           ,[password])\n"
                + "     VALUES(?, ?, ?, ?)";
        
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, c.getFirstName());
            st.setString(2, c.getLastName());
            st.setString(3, c.getEmail());
            st.setString(4, c.getPassword());
            
            if (st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException e) {
            return false;
        }
        
        return false;
    }
    
    public boolean checkOldPass(int id, String oldPass) {
        String sql = "SELECT * FROM customer WHERE id = ? and password = ?";
        
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.setString(2, oldPass);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        
        return false;
    }
    
    public boolean changePassword(int id, String newPass) {
        String sql = "UPDATE customer\n"
                + "   SET [Password] = ?\n"
                + " WHERE id = ?";
        
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, newPass);
            st.setInt(2, id);
            
            if (st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException e) {
            return false;
        }
        
        return false;
    }
    
    public Customer getCustomerById(int id) {
        String sql = """
                     SELECT * FROM customer WHERE id = ?
                     """;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Customer(rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("email"),
                        rs.getString("password"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean updateCustomer(Customer c) {
        String sql = """
                     UPDATE [dbo].[customer]
                        SET [first_name] = ?
                           ,[last_name] = ?
                           ,[address] = ?
                           ,[email] = ?
                           ,[province] = ?
                           ,[district] = ?
                           ,[ward] = ?
                      WHERE id = ?
                     """;
        
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, c.getFirstName());
            st.setString(2, c.getLastName());
            st.setString(3, c.getAddress());
            st.setString(4, c.getEmail());
            st.setString(5, c.getProvince());
            st.setString(6, c.getDistrict());
            st.setString(7, c.getWard());
            st.setInt(8, c.getId());
            
            if (st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        
        return false;
    }
    
    public List<Customer> getAll(){
        String sql = """
                     SELECT * FROM customer
                     """;
        List<Customer> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                list.add(new Customer(rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("email"),
                        rs.getString("password")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
