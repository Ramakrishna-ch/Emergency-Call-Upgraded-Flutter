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

  Future<void> _showToast1(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure?'),
          actions: [
            TextButton(
              child: Text('YES'),
              onPressed: () async {
                try {
                  await Provider.of<Login>(context, listen: false).logout();
                  Navigator.of(context1).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(StartUpScreen.routename);
                } catch (e) {
                  print(e);
                }
              },
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context1).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapBox Api Example'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => _showToast1(context)),
        ],
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
