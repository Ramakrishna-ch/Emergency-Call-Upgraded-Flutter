import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sms_test/screens/auth_screen.dart';
import '../rest/login.dart';
import '../screens/registerpage.dart';
import '../widgets/loginpage.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  static const routename = '/loginpage';
  final _form = GlobalKey<FormState>();
  Login logobj = Login();
  final loginDat = {'userid': '', 'password': ''};
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

  Future<void> validatedat(
      Function check1, BuildContext context, Function check2) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    if (loginDat['userid'].length == 10 &&
        loginDat['userid'].contains(RegExp(r'[0-9]'))) {
      print('1');
      try {
        await check1(loginDat, 'phone');
        print('login successful');
        _showToast1(
            context, 'Save password', 'phone', loginDat['userid'], check2);
      } catch (e) {
        if (e == 'Email or Phone doesn\'t exists') {
          print(e);
          _showToast(context, e);
          return;
        } else if (e == 'Wrong password') {
          print(e);
          _showToast(context, e);
          return;
        }
      }
    }
    if (loginDat['userid'].contains('@') &&
        loginDat['userid'].contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      String email = loginDat['userid'].replaceAll(".", "");
      email = email.replaceAll("@", "");
      loginDat['userid'] = email;
      try {
        await check1(loginDat, 'email');
        print('login successful');
        _showToast1(
            context, 'Save password', 'email', loginDat['userid'], check2);
      } catch (e) {
        if (e == 'Email or Phone doesn\'t exists') {
          print(e);
          _showToast(context, e);
          return;
        } else if (e == 'Wrong password') {
          print(e);
          _showToast(context, e);
          return;
        }
      }
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showToast1(BuildContext context, String message, String type,
      String id, Function check1) async {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('Save Password'),
          actions: [
            TextButton(
              child: Text('YES'),
              onPressed: () async {
                try {
                  await check1('true', type, id);
                  Navigator.of(context1).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                } catch (e) {
                  print(e);
                  Navigator.of(context1).pop();
                }
              },
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () async {
                try {
                  await check1('false', type, id);
                  Navigator.of(context1).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                } catch (e) {
                  print(e);
                  Navigator.of(context1).pop();
                }
              },
            ),
          ],
        );
      },
    );
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
            position(
              15,
              null,
              dynamicHeight / 4,
              null,
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  width: dynamicWidth * 0.8,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                  child: Form(
                    key: _form,
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
                                    hintText: 'Email or phone',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Provide emailid or number';
                                    } else if (value
                                            .contains(RegExp(r'[0-9]')) &&
                                        value.length != 10 &&
                                        !value.contains('@')) {
                                      return 'Invalid number';
                                    } else if (value.length == 10 &&
                                        value.contains(RegExp(r'[0-9]'))) {
                                      loginDat['userid'] = value;
                                      return null;
                                    } else if (!value.contains('@') ||
                                        !value.contains(RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                      return 'Invalid email';
                                    }
                                    loginDat['userid'] = value;
                                  },
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
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    loginDat['password'] = value;
                                  },
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
                            onPressed: () => validatedat(
                                logobj.loginuser, context, logobj.timeupdate),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
