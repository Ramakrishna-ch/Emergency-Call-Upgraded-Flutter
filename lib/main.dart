import 'package:sms_test/screens/registerpage.dart';
import 'package:sms_test/screens/startup_screen.dart';

import './screens/auth_screen.dart';
import './screens/location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartUpScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        GetLocationPage.routeName: (ctx) => GetLocationPage(),
        RegisterPage.routeName: (ctx) => RegisterPage()
      },
    );
  }
}
