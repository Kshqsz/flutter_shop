import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/product_list.dart';
import 'pages/cart.dart';
import 'models/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: '购物APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;  // 当前选择的页面索引

  static List<Widget> _widgetOptions = <Widget>[
    ProductListPage(),  // 首页：商品展示
    CartPage(),         // 购物车页面
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // 更新当前选中的页面
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("购物APP")),
      body: _widgetOptions.elementAt(_selectedIndex),  // 根据选择的页面显示内容
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,  // 当前选中的页面
        onTap: _onItemTapped,  // 点击底部导航栏项时切换页面
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
          ),
        ],
      ),
    );
  }
}
