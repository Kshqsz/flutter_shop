import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'checkout.dart'; // 导入结算页面

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("购物车")),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(child: Text("购物车为空"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cart.cartItems[index];
                        return ListTile(
                          leading: Image.asset(product.imageUrl),
                          title: Text(product.name),
                          subtitle: Text("￥${product.price.toStringAsFixed(2)}"), // 保留两位小数
                          trailing: IconButton(    
                            icon: Icon(Icons.remove_shopping_cart),
                            onPressed: () {
                              // 从购物车中移除商品
                              cart.removeFromCart(product);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "总价: ￥${cart.totalPrice.toStringAsFixed(2)}", // 保留两位小数
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // 跳转到结算页面
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CheckoutPage()),
                          );
                        },
                        child: Text("去结算"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
