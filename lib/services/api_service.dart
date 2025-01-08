import 'package:flutter/material.dart';
import '../models/product.dart';

List<Product> fetchProducts() {
  return [
    Product(
      name: "商品1",
      imageUrl: "assets/images/OIP.jpg",
      price: 99.99,
      sales: 500,
      deliveryLocation: "上海",
      brand: "品牌A",
    ),
    Product(
      name: "商品2",
      imageUrl: "assets/images/qkl.jpg",
      price: 199.99,
      sales: 200,
      deliveryLocation: "北京",
      brand: "品牌B",
    ),
    Product(
      name: "商品3",
      imageUrl: "assets/images/wj.jpg",
      price: 299.99,
      sales: 1000,
      deliveryLocation: "广州",
      brand: "品牌C",
    ),
    Product(
      name: "商品4",
      imageUrl: "assets/images/jita.png",
      price: 3280,
      sales: 10,
      deliveryLocation: "广州",
      brand: "品牌C",
    ),
    Product(
      name: "商品5",
      imageUrl: "assets/images/qx.jpg",
      price: 59,
      sales: 1000,
      deliveryLocation: "上海",
      brand: "品牌C",
    ),
    // 更多商品...
  ];
}
