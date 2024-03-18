/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Item {
    
    private int numModel;
    int amount;
    double price;
    int size;

    public Item() {
    }
    
    public Item(int numModel, int amount, double price, int size) {
        this.numModel = numModel;
        this.amount = amount;
        this.price = price;
        this.size = size;
    }
    
    public int getNumModel() {
        return numModel;
    }

    public void setNumModel(int numModel) {
        this.numModel = numModel;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
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
