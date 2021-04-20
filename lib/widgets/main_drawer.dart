
import 'package:flutter/material.dart';
import 'package:sms_test/screens/editDetails.dart';
import 'package:sms_test/screens/emergencycontacts.dart';
import '../screens/drawpage.dart';
import '../rest/login.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/main.jpg",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("EMERGENCY")
                ],
              )),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, EditDetails.routename);
            },
            leading: Icon(Icons.person),
            title: Text(
              "Edit Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, EmergencyContacts.routename);
            },
            leading: Icon(Icons.settings),
            title: Text("Emergency Contacts"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
                try {
                  Provider.of<Login>(context, listen: false).logout();

                  Navigator.of(context).pop();
                  // Navigator.of(context)
                  //     .pushReplacementNamed(StartUpScreen.routename);
                } catch (e) {
                  print(e);
                }
              },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }
}