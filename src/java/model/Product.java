/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Product {
    
    private int numModel;
    private String name;
    private String image;
    private double price;
    private String description;
    private String category;
    private int size;
    private int amount;

    public Product() {
    }

    public Product(String name, String image, double price, String description) {
        this.name = name;
        this.image = image;
        this.price = price;
        this.description = description;
    }

    public Product(int numModel, String name, String image, double price, String description, String category) {
        this.numModel = numModel;
        this.name = name;
        this.image = image;
        this.price = price;
        this.description = description;
        this.category = category;
    }

    public Product(int numModel, String name, String image, double price, String description) {
        this.numModel = numModel;
        this.name = name;
        this.image = image;
        this.price = price;
        this.description = description;
    }
    
    

    public Product(int numModel, int size, int amount) {
        this.numModel = numModel;
        this.size = size;
        this.amount = amount;
    }

    public int getNumModel() {
        return numModel;
    }

    public void setNumModel(int numModel) {
        this.numModel = numModel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    
    
}
