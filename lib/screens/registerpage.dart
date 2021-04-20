import 'package:flutter/material.dart';
import 'package:sms_test/screens/startup_screen.dart';
import 'dart:ui';
import '../rest/signup.dart';

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

  Signup regobj = Signup();
  Future<void> _submit(
      Function check1, BuildContext context, Function check2) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    if (edituserdetails['userid'].length == 10 &&
        edituserdetails['userid'].contains(RegExp(r'[0-9]'))) {
      try {
        await check1('phone', edituserdetails['userid']);
        try {
          await check2(edituserdetails, 'phone');
          Navigator.of(context).pop();
        } catch (e) {
          print(e);
          return;
        }
      } catch (e) {
        print('phone no already exists');
        _showToast(context, 'phone no already exists');
        return;
      }
    }
    if (edituserdetails['userid'].contains('@') &&
        edituserdetails['userid'].contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      String email = edituserdetails['userid'].replaceAll(".", "");
      email = email.replaceAll("@", "");
      edituserdetails['userid'] = email;
      try {
        await (check1('email', email));
        try {
          await check2(edituserdetails, 'email');
          Navigator.of(context).pop();
        } catch (e) {
          print(e);
          return;
        }
      } catch (e) {
        print('Email already exists');
        _showToast(context, 'Email already exists');
        return;
      }
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget textfield(
      String label, TextInputType keyname, Function validate, Function saved) {
    return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        errorStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: keyname,
      validator: validate,
      onSaved: saved,
    );
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
                            textfield(
                              'Name',
                              TextInputType.name,
                              (value) {
                                if (value.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              (value) {
                                edituserdetails['name'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            textfield('Email or Phone number',
                                TextInputType.emailAddress, (value) {
                              if (value.isEmpty) {
                                return 'Provide emailid or number';
                              } else if (value.contains(RegExp(r'[0-9]')) &&
                                  value.length != 10 &&
                                  !value.contains('@')) {
                                return 'Invalid number';
                              } else if (value.length == 10 &&
                                  value.contains(RegExp(r'[0-9]'))) {
                                edituserdetails['userid'] = value;
                                return null;
                              } else if (!value.contains('@') ||
                                  !value.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                return 'Invalid email';
                              }
                              edituserdetails['userid'] = value;
                              return null;
                            }, null),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                                'Phone or Contact number', TextInputType.phone,
                                (value) {
                              if (value.isEmpty) {
                                return 'Number cannot be empty';
                              } else if (!value.contains(RegExp(r'[0-9]')) ||
                                  value.length != 10) {
                                return 'Invalid number';
                              }
                              edituserdetails['contact'] = value;
                              return null;
                            }, null),
                            SizedBox(height: 40),
                            textfield('password', TextInputType.visiblePassword,
                                (value) {
                              if (value.isEmpty) {
                                return 'Provide password';
                              } else if (!value.contains(RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                return 'Invalid Password';
                              }
                              edituserdetails['password'] = value;
                              return null;
                            }, null),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                              'confirm password',
                              TextInputType.visiblePassword,
                              (value) {
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
                              (value) {
                                edituserdetails['cfnpass'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                              'Emergency contact',
                              TextInputType.phone,
                              (value) {
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
                              (value) {
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
                  onPressed: () =>
                      _submit(regobj.checkid, context, regobj.signupuser),
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
