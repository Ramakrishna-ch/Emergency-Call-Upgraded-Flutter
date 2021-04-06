import 'package:flutter/material.dart';
import 'package:sms_test/screens/startup_screen.dart';
import 'dart:ui';

import 'package:sms_test/widgets/loginpage.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/registerpage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _gender = ['Male', 'Female'];
  final _form = GlobalKey<FormState>();
  final edituserdetails = {
    'name': '',
    'userid': '',
    'contact': '',
    'password': '',
    'cfnpass': '',
    'gender': 'Male',
    'emergency': '',
  };
  void genda() {
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    print(edituserdetails);
  }

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
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenht,
          width: screenwt,
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
          child: Column(
            children: <Widget>[
              Card(
                child: Text('SignUp'),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: screenht * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Name',
                                errorStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                edituserdetails['name'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Email or Phone number',
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Provide emailid or number';
                                } else if (value.contains(RegExp(r'[0-9]')) &&
                                    value.length != 10) {
                                  return 'Invalid number';
                                } else if (value.length == 10 &&
                                    value.contains(RegExp(r'[0-9]'))) {
                                  return null;
                                } else if (!value.contains('@') ||
                                    !value.contains(RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                  return 'Invalid email';
                                }
                                edituserdetails['userid'] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Phone or Contact number',
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Number cannot be empty';
                                } else if (!value.contains(RegExp(r'[0-9]')) ||
                                    value.length != 10) {
                                  return 'Invalid number';
                                }
                                edituserdetails['contact'] = value;
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'password',
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Provide password';
                                } else if (!value.contains(RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                  return 'Invalid Password';
                                }
                                edituserdetails['password'] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintText: 'confirm password',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please re-enter password';
                                } else if (!value.contains(RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                  return 'Invalid Password';
                                } else if (edituserdetails['password'] !=
                                    value) {
                                  return 'Password doestn\'t match';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                edituserdetails['cfnpass'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Emergency contact',
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Number cannot be empty';
                                } else if (!value.contains(RegExp(r'[0-9]')) ||
                                    value.length != 10) {
                                  return 'Invalid number';
                                } else if (edituserdetails['contact'] ==
                                    value) {
                                  return 'Enter different phone number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                edituserdetails['emergency'] = value;
                              },
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  'Gender:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                    items: _gender
                                        .map<DropdownMenuItem<String>>(
                                            (String index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            index,
                                            style: TextStyle(
                                                foreground: Paint()
                                                  ..shader = linearGradient),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: edituserdetails['gender'],
                                    onChanged: (String value) {
                                      setState(() {
                                        edituserdetails['gender'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () => genda(),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Already Registered? Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
