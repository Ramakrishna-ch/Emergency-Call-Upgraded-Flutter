import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class WebView1 extends StatefulWidget {
  static const routename = '/webview';
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView1> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationval = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapview'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl: "https://maps.google.com/maps/?q=" + locationval,
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
