/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Order {
    
    private int orderID;
    private int customerID;
    private String address;
    private String orderDate;
    private String status;

    public Order() {
    }

    public Order(int customerID, String address, String orderDate, String status) {
        this.customerID = customerID;
        this.address = address;
        this.orderDate = orderDate;
        this.status = status;
    }

    public Order(int orderID, int customerID, String address, String orderDate, String status) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.address = address;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", customerID=" + customerID + ", address=" + address + ", orderDate=" + orderDate + ", status=" + status + '}';
    }
    
    
}
