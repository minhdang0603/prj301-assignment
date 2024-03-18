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
import model.Category;

/**
 *
 * @author Admin
 */
public class CategoriesDAO {

    private PreparedStatement st;
    private ResultSet rs;
    private Connection conn = DBContext.getConnection();

    public List<Category> getAllCategories() {
        String sql = "select * from category";
        List<Category> list = new ArrayList<>();
        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("category_name")));
            }
        } catch (SQLException e) {
        }
        return list;
    }
}
