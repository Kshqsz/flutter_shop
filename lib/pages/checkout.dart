import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'webview_page.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("结算")),
      body: Consumer<CartModel>( // 使用 Consumer 来监听购物车状态
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(child: Text("购物车为空，无法结算"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "购物车商品",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cart.cartItems[index];
                        return ListTile(
                          leading: Image.asset(product.imageUrl),
                          title: Text(product.name),
                          subtitle: Text("￥${product.price.toStringAsFixed(2)}"), // 保留两位小数
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
                          // 点击结算按钮，跳转到 WebView 页面并传递总金额
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                totalPrice: cart.totalPrice, // 传递总金额参数
                              ),
                            ),
                          );
                        },
                        child: Text("结算"),
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
