import 'package:provider/provider.dart';
import 'package:sms_test/screens/startup_screen.dart';
import 'package:sms_test/widgets/loginpage.dart';
import '../screens/location.dart';
import 'package:flutter/material.dart';
import '../rest/auth.dart';
import '../rest/login.dart';
import './drawpage.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

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
        crossAxisAlignment: CrossAxisAlignment.end,
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
                  heroTag: null,
                  child: Text('oAuth'),
                  onPressed: sample,
                ),
              ],
            ),
          ),
          FloatingActionButton(
            heroTag: null,
            child: Text('go draw'),
            onPressed: () {
              // Navigator.pushNamed(context, GetLocationPage.routeName,
              //     arguments: {
              //       'tokenType': tokentype,
              //       'accessToken': accesstoken,
              //     });
              Navigator.pushNamed(context, DrawPage.routename);
            },
          ),
        ],
      ),
    );
  }
}
