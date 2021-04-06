import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

class LoginPage extends StatelessWidget {
  
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Colors.red,
      Colors.redAccent,
      Colors.pink,
      Colors.deepOrange,
      Colors.orange,
      Colors.orangeAccent,
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: screenwt * 0.8,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10, top: 1),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                      right: 10,
                    ),
                    child: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
              child: TextButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextButton(
              child: Text('Forgot password?'),
            ),
            SizedBox(
              height: 88,
            ),
            TextButton(
              child: Text(
                'New User? Register Now',
                style: TextStyle(foreground: Paint()..shader = linearGradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
