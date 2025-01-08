import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../services/api_service.dart';
import 'product_detail.dart'; // 引入商品详情页

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String selectedSort = 'price'; // 排序方式：'price' or 'sales'
  bool isAscending = true; // 升序或降序
  String? selectedBrand;
  String? selectedLocation;

  // 模拟的商品数据列表
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // 加载商品数据
  Future<void> _loadProducts() async {
    List<Product> products = await fetchProducts();
    setState(() {
      allProducts = products;
      displayedProducts = List.from(allProducts); // 初始显示所有商品
    });
  }

  // 根据排序和筛选条件更新商品列表
  void _applyFiltersAndSort() {
    List<Product> filteredProducts = List.from(allProducts);

    // 筛选: 根据发货地和品牌
    if (selectedLocation != null) {
      filteredProducts = filteredProducts
          .where((product) => product.deliveryLocation == selectedLocation)
          .toList();
    }
    if (selectedBrand != null) {
      filteredProducts = filteredProducts
          .where((product) => product.brand == selectedBrand)
          .toList();
    }

    // 排序: 根据价格或销量
    filteredProducts.sort((a, b) {
      if (selectedSort == 'price') {
        return isAscending
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price);
      } else {
        return isAscending
            ? a.sales.compareTo(b.sales)
            : b.sales.compareTo(a.sales);
      }
    });

    setState(() {
      displayedProducts = filteredProducts;
    });
  }

  // 筛选和排序选择框
  Widget _buildFilterSortWidgets() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton<String>(
            value: selectedSort,
            onChanged: (value) {
              setState(() {
                selectedSort = value!;
              });
              _applyFiltersAndSort();
            },
            items: [
              DropdownMenuItem(child: Text("按价格排序"), value: 'price'),
              DropdownMenuItem(child: Text("按销量排序"), value: 'sales'),
            ],
          ),
          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
              });
              _applyFiltersAndSort();
            },
          ),
          DropdownButton<String>(
            value: selectedLocation,
            onChanged: (value) {
              setState(() {
                selectedLocation = value;
              });
              _applyFiltersAndSort();
            },
            hint: Text("选择发货地"),
            items: ['全国', '上海', '北京', '广州']
                .map<DropdownMenuItem<String>>(
                  (location) => DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  ),
                )
                .toList(),
          ),
          DropdownButton<String>(
            value: selectedBrand,
            onChanged: (value) {
              setState(() {
                selectedBrand = value;
              });
              _applyFiltersAndSort();
            },
            hint: Text("选择品牌"),
            items: ['品牌A', '品牌B', '品牌C']
                .map<DropdownMenuItem<String>>(
                  (brand) => DropdownMenuItem<String>(
                    value: brand,
                    child: Text(brand),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品列表")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildFilterSortWidgets(),
          ),
          Expanded(
            child: displayedProducts.isEmpty
                ? Center(child: Text("没有符合条件的商品"))
                : ListView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return ListTile(
                        leading: Image.asset(product.imageUrl),
                        title: Text(product.name),
                        subtitle: Text(
                            "￥${product.price} | 销量: ${product.sales} | 发货地: ${product.deliveryLocation} | 品牌: ${product.brand}"),
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            // 添加到购物车逻辑
                            Provider.of<CartModel>(context, listen: false)
                                .addToCart(product);

                            // 显示 SnackBar 提示
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${product.name} 已加入购物车"),
                                duration: Duration(seconds: 2), // 持续时间
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          // 点击商品跳转到详情页面
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
