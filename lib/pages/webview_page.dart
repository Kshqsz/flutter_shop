import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final double totalPrice; // 接收总金额参数

  WebViewPage({required this.totalPrice});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // 初始化 WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // 页面加载完成后传递金额到 HTML
            _controller.runJavaScript('setOrderAmount(${widget.totalPrice.toStringAsFixed(2)})');
          },
        ),
      )
      ..loadFlutterAsset('assets/html/payment.html'); // 加载本地 HTML 文件
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("支付页面"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
