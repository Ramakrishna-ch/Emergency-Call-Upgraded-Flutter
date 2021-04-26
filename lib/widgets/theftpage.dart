import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../rest/auth.dart';
import '../rest/getDetails.dart';
import '../rest/getdata.dart';
import '../rest/location.dart';
import '../rest/login.dart';
import '../rest/sms.dart';
import 'package:provider/provider.dart';

_launchURLBrowser() async {
  const url = 'https://youtu.be/33fVFazP2jc';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class TheftScreen extends StatelessWidget {
  static const routeName = '/theft-screen';

  Future<void> sendMessage(
      BuildContext context, String id, List<String> contacts) async {
    var locval1 =
        await Provider.of<LocationClass>(context, listen: false).showloc();
    var tokendat = await Provider.of<Auth>(context, listen: false).token();

    var mapdata1 = await Provider.of<GetData>(context, listen: false)
        .getPlaces(tokendat['type'], tokendat['token'], locval1);
    await Provider.of<GetDetails>(context, listen: false).fetchDat(mapdata1);
   String message =
        "Emergency for $id at\nLocation: https://maps.google.com/maps/?q=" +
            locval1 +
            "\nTake Action!!!";
    contacts.forEach((element) {
      Provider.of<SmsSend>(context, listen: false).sendSms(message, element);
       _showToast(context, 'SMS sent successfully.');
    });
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
    final userid = Provider.of<Login>(context).userdat['name'];
    final contacts = Provider.of<Login>(context).emerContacts;
    return Scaffold(
      // backgroundColor: Color(0xFFbb377d),
      backgroundColor: Color(0xFFfbd3e9),
      appBar: AppBar(
        backgroundColor: Color(0xFFbb377d),
        automaticallyImplyLeading: false,
        title: Text("Theft Screen"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder(
        initialData: false,
        stream: slimyCard.stream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 70),
              SlimyCard(
                color: Color(0xFFbb377d),
                topCardWidget: topCardWidget(
                    (snapshot.data)
                        ? 'assets/images/9.jpg'
                        : 'assets/images/15.jpg',
                    context,
                    userid,
                    contacts),
                bottomCardWidget: bottomCardWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget topCardWidget(String imagePath, BuildContext context, String id,
      List<String> contacts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Instructions',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Center(
          child: Text(
            'When Someone involve in the theft or the action stealing your belongings'
            '                                                                                '
            ' Click On the Police Help',
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton.icon(
          icon: Icon(
            Icons.local_police_outlined,
            color: Colors.white,
            size: 24.0,
          ),
          label: Text('Police Help'),
          onPressed: () => sendMessage(context, id, contacts),
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomCardWidget() {
    return Column(
      children: [
        Text(
          'Safety Tips',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.video_library,
              color: Colors.white,
              size: 22.0,
            ),
            label: Text('click to see video'),
            onPressed: _launchURLBrowser,
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
