import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sms_test/screens/registerpage.dart';
import 'package:sms_test/widgets/loginpage.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  static const routename = '/loginpage';
  Widget position(
      double left, double right, double top, double bottom, Widget child) {
    return Positioned(
      child: child,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  void printing(double sizeval, double widtval) {
    print(sizeval.toString() + " " + widtval.toString());
  }

  @override
  Widget build(BuildContext context) {
    final dynamicHeight = MediaQuery.of(context).size.height;
    final dynamicWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.red,
                    Colors.redAccent,
                    Colors.pink,
                    Colors.deepOrange,
                    Colors.orange,
                    Colors.orangeAccent,
                  ],
                ),
              ),
            ),
            position(
              0,
              null,
              35,
              20,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: dynamicWidth * 0.9,
                height: dynamicHeight,
              ),
            ),
            position(15, null, dynamicHeight / 4, null, LoginPage()),
            position(
              null,
              dynamicWidth * .1,
              null,
              50,
              Arc(
                edge: Edge.LEFT,
                height: dynamicHeight * 0.16 * 0.5,
                arcType: ArcType.CONVEX,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepOrange,
                        Colors.orange,
                        Colors.orangeAccent,
                      ],
                    ),
                  ),
                  width: dynamicHeight * 0.16 * 0.5,
                  height: dynamicHeight * 0.16,
                ),
              ),
            ),
            position(
              null,
              dynamicWidth * .05,
              null,
              78,
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
                },
                foregroundColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
