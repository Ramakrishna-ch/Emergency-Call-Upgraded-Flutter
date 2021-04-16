import 'package:flutter/material.dart';

class EmergencyContacts extends StatefulWidget {
  static const routename = 'emergencycontacts';
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  final _form = GlobalKey<FormState>();
  var _editedConatcts = [];
  var _initContacts = [];

  bool isinit = true;
  @override
  void didChangeDependencies() {
    if (isinit) {}
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 40,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Text(
                'Emergency contact 1',
                style: TextStyle(fontSize: 23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
