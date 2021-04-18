import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_test/rest/login.dart';

class EditDetails extends StatefulWidget {
  static const routename = '/editdetails';
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _form = GlobalKey<FormState>();
  var _editedUserDetails = {
    'name': '',
    'userid': '',
    'contact': '',
    'password': '',
    'cfnpass': '',
    'gender': '',
    'emergency': '',
  };

  var _initvalues = {
    'name': '',
    'userid': '',
    'contact': '',
    'password': '',
    'cfnpass': '',
    'gender': '',
    'emergency': '',
  };
  final List<String> _gender = ['Male', 'Female'];
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(67, 206, 162, 1),
      Color.fromRGBO(24, 90, 157, 1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  bool isinit = true;
  bool edit = false;
  @override
  void didChangeDependencies() {
    if (isinit) {
      _editedUserDetails = Provider.of<Login>(context).userdat;
      _initvalues = _editedUserDetails;
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit(BuildContext context) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();

    if (_editedUserDetails['userid'].length == 10 &&
        _editedUserDetails['userid'].contains(RegExp(r'[0-9]'))) {
      try {
        if (_initvalues.values == _editedUserDetails.values) {
          _showToast(context, 'Details not modified');
          return;
        }
        await Provider.of<Login>(context, listen: false)
            .editDetails('phone', _editedUserDetails);
        _showToast(context, 'Details modified successfully');
      } catch (e) {
        print(e);

        return;
      }
    } else if (_editedUserDetails['userid'].contains('@') &&
        _editedUserDetails['userid'].contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      String email = _editedUserDetails['userid'].replaceAll(".", "");
      email = email.replaceAll("@", "");
      _editedUserDetails['userid'] = email;
      try {
        if (_initvalues.values == _editedUserDetails.values) {
          _showToast(context, 'Details not modified');
          return;
        }
        await Provider.of<Login>(context, listen: false)
            .editDetails('email', _editedUserDetails);
        _showToast(context, 'Details modified successfully');
      } catch (e) {
        print(e);

        return;
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

  Widget textfield(String initname, bool auth, String label,
      TextInputType keyname, Function validate, Function saved) {
    if (initname == 'cfnpass') {
      return Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              cursorColor: Colors.white,
              obscureText: eyeval,
              readOnly: initname == 'userid' ? true : !edit,
              initialValue: _initvalues[initname],
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
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
            ),
          ),
          !eyeval
              ? IconButton(
                  icon: Icon(Icons.visibility_outlined),
                  onPressed: () {
                    setState(() {
                      eyeval = !eyeval;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      eyeval = !eyeval;
                    });
                  }),
        ],
      );
    } else {
      return TextFormField(
        cursorColor: Colors.white,
        readOnly: initname == 'userid' ? true : !edit,
        initialValue: _initvalues[initname],
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
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
  }

  bool eyeval = false;

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 206, 162, 1),
        title: Text('Edit Profile'),
        actions: [
          Switch(
              activeColor: Color.fromRGBO(24, 90, 157, 1),
              value: edit,
              onChanged: (val) {
                setState(() {
                  edit = val;
                });
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        height: screenht,
        width: screenwt,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(67, 206, 162, 1),
              Color.fromRGBO(24, 90, 157, 1),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: screenht * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white70,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          textfield(
                            'name',
                            false,
                            'Name',
                            TextInputType.name,
                            (value) {
                              if (value.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              _editedUserDetails = {
                                'name': value,
                                'userid': _editedUserDetails['userid'],
                                'contact': _editedUserDetails['contact'],
                                'password': _editedUserDetails['password'],
                                'cfnpass': _editedUserDetails['cfnpass'],
                                'gender': _editedUserDetails['gender'],
                                'emergency': _editedUserDetails['emergency']
                              };
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textfield('userid', true, 'Email or Phone number',
                              TextInputType.emailAddress, (value) {
                            if (value.isEmpty) {
                              return 'Provide emailid or number';
                            } else if (value.contains(RegExp(r'[0-9]')) &&
                                value.length != 10 &&
                                !value.contains('@')) {
                              return 'Invalid number';
                            } else if (value.length == 10 &&
                                value.contains(RegExp(r'[0-9]'))) {
                              _editedUserDetails = {
                                'name': _editedUserDetails['name'],
                                'userid': value,
                                'contact': _editedUserDetails['contact'],
                                'password': _editedUserDetails['password'],
                                'cfnpass': _editedUserDetails['cfnpass'],
                                'gender': _editedUserDetails['gender'],
                                'emergency': _editedUserDetails['emergency']
                              };
                              return null;
                            } else if (!value.contains('@') ||
                                !value.contains(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                              return 'Invalid email';
                            }
                            _editedUserDetails = {
                              'name': _editedUserDetails['name'],
                              'userid': value,
                              'contact': _editedUserDetails['contact'],
                              'password': _editedUserDetails['password'],
                              'cfnpass': _editedUserDetails['cfnpass'],
                              'gender': _editedUserDetails['gender'],
                              'emergency': _editedUserDetails['emergency']
                            };
                            return null;
                          }, null),
                          SizedBox(
                            height: 40,
                          ),
                          textfield('contact', false, 'Phone or contact number',
                              TextInputType.phone, (value) {
                            if (value.isEmpty) {
                              return 'Number cannot be empty';
                            } else if (!value.contains(RegExp(r'[0-9]')) ||
                                value.length != 10) {
                              return 'Invalid number';
                            }
                            _editedUserDetails = {
                              'name': _editedUserDetails['name'],
                              'userid': _editedUserDetails['userid'],
                              'contact': value,
                              'password': _editedUserDetails['password'],
                              'cfnpass': _editedUserDetails['cfnpass'],
                              'gender': _editedUserDetails['gender'],
                              'emergency': _editedUserDetails['emergency']
                            };
                            return null;
                          }, null),
                          SizedBox(height: 40),
                          textfield('password', false, 'Password',
                              TextInputType.visiblePassword, (value) {
                            if (value.isEmpty) {
                              return 'Provide password';
                            } else if (!value.contains(RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                              return 'Invalid Password';
                            }
                            _editedUserDetails = {
                              'name': _editedUserDetails['name'],
                              'userid': _editedUserDetails['userid'],
                              'contact': _editedUserDetails['contact'],
                              'password': value,
                              'cfnpass': _editedUserDetails['cfnpass'],
                              'gender': _editedUserDetails['gender'],
                              'emergency': _editedUserDetails['emergency']
                            };
                            return null;
                          }, null),
                          SizedBox(
                            height: 40,
                          ),
                          textfield(
                            'cfnpass',
                            false,
                            'Confirm password',
                            TextInputType.visiblePassword,
                            (value) {
                              if (value.isEmpty) {
                                return 'Please re-enter password';
                              } else if (!value.contains(RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                return 'Invalid Password';
                              } else if (_editedUserDetails['password'] !=
                                  value) {
                                return 'Password doestn\'t match';
                              }
                              return null;
                            },
                            (value) {
                              _editedUserDetails = {
                                'name': _editedUserDetails['name'],
                                'userid': _editedUserDetails['userid'],
                                'contact': _editedUserDetails['contact'],
                                'password': _editedUserDetails['password'],
                                'cfnpass': value,
                                'gender': _editedUserDetails['gender'],
                                'emergency': _editedUserDetails['emergency']
                              };
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textfield(
                            'emergency',
                            false,
                            'Emergency contact',
                            TextInputType.phone,
                            (value) {
                              if (value.isEmpty) {
                                return 'Number cannot be empty';
                              } else if (!value.contains(RegExp(r'[0-9]')) ||
                                  value.length != 10) {
                                return 'Invalid number';
                              } else if (_editedUserDetails['contact'] ==
                                  value) {
                                return 'Enter different phone number';
                              }
                              return null;
                            },
                            (value) {
                              _editedUserDetails = {
                                'name': _editedUserDetails['name'],
                                'userid': _editedUserDetails['userid'],
                                'contact': _editedUserDetails['contact'],
                                'password': _editedUserDetails['password'],
                                'cfnpass': _editedUserDetails['cfnpass'],
                                'gender': _editedUserDetails['gender'],
                                'emergency': value,
                              };
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
                                  items: _gender.map<DropdownMenuItem<String>>(
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
                                  value: _editedUserDetails['gender'],
                                  onChanged: (String value) {
                                    setState(() {
                                      _editedUserDetails = {
                                        'name': _editedUserDetails['name'],
                                        'userid': _editedUserDetails['userid'],
                                        'contact':
                                            _editedUserDetails['contact'],
                                        'password':
                                            _editedUserDetails['password'],
                                        'cfnpass':
                                            _editedUserDetails['cfnpass'],
                                        'gender': value,
                                        'emergency':
                                            _editedUserDetails['emergency'],
                                      };
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
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: !edit ? null : () => _submit(context),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
