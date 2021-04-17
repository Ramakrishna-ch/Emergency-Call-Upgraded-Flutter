import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_test/rest/login.dart';

class EmergencyContacts extends StatefulWidget {
  static const routename = 'emergencycontacts';
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  final _form = GlobalKey<FormState>();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(187, 210, 197, 1),
      Color.fromRGBO(83, 105, 118, 1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  var _editedContacts = [];
  var _initContacts = ['', '', ''];
  bool edit = false;
  bool isinit = true;
  @override
  void didChangeDependencies() {
    if (isinit) {
      _editedContacts = Provider.of<Login>(context).emer;
      while (_editedContacts.length < 3) {
        print(_editedContacts);
        _editedContacts.add('');
      }

      _initContacts = _editedContacts;
      print(_initContacts);
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget textField(String title, int n, Function validate, Function save) {
    // String initval;
    // if (n == 0 && _initContacts.isNotEmpty) {
    //   initval = _initContacts[0];
    // } else if (n == 1 && _initContacts.length == 2) {
    //   initval = _initContacts[1];
    // } else if (n == 2 && _initContacts.length == 3) {
    //   initval = _initContacts[2];
    // } else {
    //   initval = null;
    // }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white70,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                readOnly: !edit,
                initialValue: _initContacts[n],
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: title,
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
                validator: validate,
                onSaved: save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    String finalcon = _editedContacts.join(" ");
    try {
      await Provider.of<Login>(context, listen: false).editContacts(finalcon);
      _showToast(context, 'Saved Successfully');
    } catch (e) {
      _showToast(context, e);
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

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Color.fromRGBO(83, 105, 118, 1),
        actions: [
          Switch(
              value: edit,
              onChanged: (val) {
                setState(() {
                  edit = val;
                });
              }),
        ],
      ),
      body: Container(
        height: screenht,
        width: screenwt,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(187, 210, 197, 1),
              Color.fromRGBO(83, 105, 118, 1),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      textField('Parent\'s Number', 0, (value) {
                        if (value.isEmpty) {
                          return 'Number cannot be empty';
                        } else if (!value.contains(RegExp(r'[0-9]')) ||
                            value.length != 10) {
                          return 'Invalid number';
                        }
                        _editedContacts[0] = value;
                      }, null),
                      textField('Close Relative or Freind', 1, (value) {
                        if (value.isEmpty) {
                          return 'Number cannot be empty';
                        } else if (!value.contains(RegExp(r'[0-9]')) ||
                            value.length != 10) {
                          return 'Invalid number';
                        } else if (_editedContacts[0] == value) {
                          return 'Enter different phone number';
                        }
                        _editedContacts[1] = value;
                      }, null),
                      textField('Gaurdian Number', 2, (value) {
                        if (value.isEmpty) {
                          return 'Number cannot be empty';
                        } else if (!value.contains(RegExp(r'[0-9]')) ||
                            value.length != 10) {
                          return 'Invalid number';
                        } else if (_editedContacts[1] == value) {
                          return 'Enter different phone number';
                        }
                      }, (value) {
                        _editedContacts[2] = value;
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(187, 210, 197, 1),
                          ),
                          child: TextButton(
                            onPressed: () => _submit(context),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
