import 'package:flutter/material.dart';

class EmergencyContacts extends StatefulWidget {
  static const routename = 'emergencycontacts';
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('emergency contacts list page'),
    );
  }
}
