import 'package:provider/provider.dart';
import 'package:sms_test/screens/drawpage.dart';
import 'package:sms_test/screens/registerpage.dart';
import 'package:sms_test/screens/splash_screen.dart';
import 'package:sms_test/screens/startup_screen.dart';
import 'package:sms_test/widgets/loginpage.dart';
import './rest/login.dart';
import './screens/auth_screen.dart';
import './screens/location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Login(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: Login().checkuser(),
          builder: (ctx, autosnap) {
            if (autosnap.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else if (autosnap.connectionState == ConnectionState.done) {
              if (autosnap.data == true) {
                print('main');
                return AuthScreen();
              } else {
                print('fail');
                return StartUpScreen();
              }
            }
          },
        ),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          GetLocationPage.routeName: (ctx) => GetLocationPage(),
          RegisterPage.routeName: (ctx) => RegisterPage(),
          StartUpScreen.routename: (ctx) => StartUpScreen(),
          DrawPage.routename: (ctx) => DrawPage(),
        },
      ),
    );
  }
}
