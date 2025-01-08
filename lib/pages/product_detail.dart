import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 自定义返回逻辑
            Navigator.pop(context); // 返回到商品列表页面
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品图片
            Center(
              child: Image.asset(
                product.imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            // 商品信息
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "价格: ￥${product.price}",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 8.0),
            Text("销量: ${product.sales}"),
            SizedBox(height: 8.0),
            Text("发货地: ${product.deliveryLocation}"),
            SizedBox(height: 8.0),
            Text("品牌: ${product.brand}"),
            SizedBox(height: 16.0),
            // 加入购物车按钮
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // 加入购物车逻辑
                  Provider.of<CartModel>(context, listen: false).addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.name} 已加入购物车")),
                  );
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text("加入购物车"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
