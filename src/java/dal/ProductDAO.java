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
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductDAO {
    
    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();
    
    public List<Product> getAllProduct() {
        String sql = "select * from shoes s join category c on s.cartegory_id = c.id";
        List<Product> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("category_name")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
    
    public List<Product> getProductByCategory(int categoryID) {
        String sql = "select * from shoes s join category c on s.cartegory_id = c.id where c.id = ?";
        List<Product> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, categoryID);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("category_name")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
    
    public List<Product> searchProduct(String[] sizeArr, int categoryId, String price) {
        List<Product> list = new ArrayList<>();
        String sql = "select distinct s.num_model, [name], [image], price, [description], category_name\n"
                + "from shoes s join category c on s.cartegory_id = c.id\n"
                + "left join product p on s.num_model = p.num_model where c.id = ? and amount > 0";
        if (sizeArr != null) {
            sql += " and size in(";
            for (int i = 0; i < sizeArr.length; i++) {
                if (i != (sizeArr.length - 1)) {
                    sql += sizeArr[i] + ", ";
                } else {
                    sql += sizeArr[i] + ")";
                }
            }
        }
        if (price != null) {
            switch (price) {
                case "1":
                    sql += " order by price desc";
                    break;
                default:
                    sql += " order by price asc";
                    break;
            }
        }
        
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, categoryId);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("category_name")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
    
    public List<Product> searchProductByName(String name) {
        String sql = "select * from shoes s join category c on s.cartegory_id = c.id "
                + "where name like '%" + name + "%'";
        List<Product> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("category_name")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
    
    public Product getProductByID(int id) {
        String sql = """
                    select distinct s.num_model, [name], [image], price, [description], category_name
                    from shoes s join category c on s.cartegory_id = c.id where s.num_model = ?
                     """;
        Product p = null;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                p = new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("category_name"));
            }
            return p;
        } catch (SQLException e) {
        }
        return p;
    }
    
    public List<Product> getProductSizeAndAmount(int num_model) {
        String sql = """
                     select * from product where num_model = ?
                     """;
        List<Product> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, num_model);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("num_model"),
                        rs.getInt("size"),
                        rs.getInt("amount")));
            }
        } catch (SQLException e) {
        }
        
        return list;
    }
    
    public Product getProductBySizeAndID(int num_model, int size) {
        String sql = """
                     select * from product where num_model = ? and size = ?
                     """;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, num_model);
            st.setInt(2, size);
            rs = st.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt("num_model"),
                        rs.getInt("size"),
                        rs.getInt("amount"));
            }
        } catch (SQLException e) {
        }
        
        return null;
    }
    
    public boolean updateProductAmount(Product p) {
        String sql = """
                     UPDATE [dbo].[product]
                        SET [amount] = ?
                      WHERE num_model = ? and size = ?
                     """;
        
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, p.getAmount());
            st.setInt(2, p.getNumModel());
            st.setInt(3, p.getSize());
            
            if (st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        
        return false;
    }
    
    public boolean addProduct(Product p, int cateID) {
        
        String sql = """
                     INSERT INTO [dbo].[shoes]
                                ([name]
                                ,[image]
                                ,[price]
                                ,[description]
                                ,[cartegory_id])
                          VALUES(?,?,?,?,?)
                     """;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, p.getName());
            st.setString(2, p.getImage());
            st.setDouble(3, p.getPrice());
            st.setString(4, p.getDescription());
            st.setInt(5, cateID);
            
            if (st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException e) {
        }
        
        return false;
    }
    
    public boolean deleteProduct(int numModel) {
        
        String sql = """
                     delete shoes where num_model = ? 
                     """;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, numModel);
            
            if (st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException e) {
        }
        
        return false;
    }
    
    public boolean addProductSizeAndAmount(Product p, int size) {
        
        String sql = """
                     insert into product values(?, ?, ?)
                     """;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, p.getNumModel());
            st.setInt(2, size);
            st.setInt(3, 0);
            
            if (st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException e) {
        }
        
        return false;
    }
    
    public Product getNewestProduct() {
        String sql = """
                     select top 1 * from shoes order by num_model desc
                     """;
        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("num_model"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"));
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public boolean updateProduct(Product p, int cateID) {
        String sql = """
                     UPDATE [dbo].[shoes]
                        SET [name] = ?
                           ,[image] = ?
                           ,[price] = ?
                           ,[description] = ?
                           ,[cartegory_id] = ?
                      WHERE num_model = ?
                     """;
        
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, p.getName());
            st.setString(2, p.getImage());
            st.setDouble(3, p.getPrice());
            st.setString(4, p.getDescription());
            st.setInt(5, cateID);
            st.setInt(6, p.getNumModel());
            if (st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }
}
