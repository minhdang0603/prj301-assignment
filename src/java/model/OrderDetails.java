/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class OrderDetails {
    
    private int orderID;
    private int numModel;
    private int quantity;
    private double price;
    private int size;

    public OrderDetails() {
    }

    public OrderDetails(int orderID, int numModel, int quantity, double price, int size) {
        this.orderID = orderID;
        this.numModel = numModel;
        this.quantity = quantity;
        this.price = price;
        this.size = size;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getNumModel() {
        return numModel;
    }

    public void setNumModel(int numModel) {
        this.numModel = numModel;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
