import 'package:provider/provider.dart';
import './screens/drawpage.dart';
import './screens/editDetails.dart';
import './screens/emergencycontacts.dart';
import './screens/registerpage.dart';
import './screens/splash_screen.dart';
import './screens/startup_screen.dart';
import './widgets/loginpage.dart';
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
        ChangeNotifierProvider(
          create: (ctx) => Login(),
        ),
      ],
      child: Consumer<Login>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isauth
              ? DrawPage()
              : FutureBuilder(
                  future: auth.checkuser(),
                  builder: (ctx, autosnap) =>
                      autosnap.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : StartUpScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            GetLocationPage.routeName: (ctx) => GetLocationPage(),
            RegisterPage.routeName: (ctx) => RegisterPage(),
            StartUpScreen.routename: (ctx) => StartUpScreen(),
            DrawPage.routename: (ctx) => DrawPage(),
            EditDetails.routename: (ctx) => EditDetails(),
            EmergencyContacts.routename: (ctx) => EmergencyContacts(),
          },
        ),
      ),
    );
  }
}
