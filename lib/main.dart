import 'package:provider/provider.dart';
import 'package:sms_test/rest/auth.dart';
import 'package:sms_test/rest/getDetails.dart';
import 'package:sms_test/rest/getdata.dart';
import 'package:sms_test/rest/location.dart';
import './screens/drawpage.dart';
import './screens/editDetails.dart';
import './screens/emergencycontacts.dart';
import './screens/registerpage.dart';
import './screens/splash_screen.dart';
import './screens/startup_screen.dart';
import './rest/login.dart';
import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
import './widgets/accidentpage.dart';
import './widgets/firepage.dart';
import './widgets/nature.dart';
import './widgets/theftpage.dart';
import './widgets/womenpage.dart';

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
        ChangeNotifierProvider(
          create: (ctx) => LocationClass(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: GetData(),
        ),
        ChangeNotifierProvider.value(
          value: GetDetails(),
        ),
      ],
      child: Consumer<Login>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isauth
              ? HomePage()
              : FutureBuilder(
                  future: auth.checkuser(),
                  builder: (ctx, autosnap) =>
                      autosnap.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : StartUpScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            RegisterPage.routeName: (ctx) => RegisterPage(),
            StartUpScreen.routename: (ctx) => StartUpScreen(),
            HomePage.routeName: (ctx) => HomePage(),
            EditDetails.routename: (ctx) => EditDetails(),
            EmergencyContacts.routename: (ctx) => EmergencyContacts(),
            NaturalCalamityScreen.routeName: (ctx) => NaturalCalamityScreen(),
            WomenHarassScreen.routeName: (ctx) => WomenHarassScreen(),
            TheftScreen.routeName: (ctx) => TheftScreen(),
            AccidentScreen.routeName: (ctx) => AccidentScreen(),
            FireScreen.routeName: (ctx) => FireScreen(),
          },
        ),
      ),
    );
  }
}
