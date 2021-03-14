import '../screens/location.dart';
import 'package:flutter/material.dart';
import '../rest/auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String tokentype;
  String accesstoken;

  Auth auth = Auth();

  void sample() {
    setState(() {
      auth.token();
      tokentype = auth.tokenType;
      accesstoken = auth.accessToken;
      print(tokentype);
      print(accesstoken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapBox Api Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(tokentype == null ? 'NO data' : tokentype),
                      Text(accesstoken == null ? 'NO data' : accesstoken),
                    ],
                  ),
                ),
                FloatingActionButton(
                  child: Text('oAuth'),
                  onPressed: sample,
                ),
              ],
            ),
          ),
          FloatingActionButton(
            child: Text('GetLocation'),
            onPressed: () {
              Navigator.pushNamed(context, GetLocationPage.routeName,
                  arguments: {
                    'tokenType': tokentype,
                    'accessToken': accesstoken,
                  });
            },
          ),
        ],
      ),
    );
  }
}
