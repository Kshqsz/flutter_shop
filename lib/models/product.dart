class Product {
  final String name;
  final String imageUrl;
  final double price;
  final int sales;  // 销量
  final String deliveryLocation;  // 发货地
  final String brand;             // 品牌

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.sales,
    required this.deliveryLocation,
    required this.brand,
  });
}
