import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:sms_test/rest/auth.dart';
import 'package:sms_test/rest/getDetails.dart';
import 'package:sms_test/rest/getdata.dart';
import 'package:sms_test/rest/location.dart';
import 'package:sms_test/rest/sms.dart';
import 'package:url_launcher/url_launcher.dart';
import '../rest/login.dart';

_launchURLBrowser() async {
  const url = 'https://youtu.be/33fVFazP2jc';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class WomenHarassScreen extends StatefulWidget {
  static const routeName = '/women-screen';

  @override
  _WomenHarassScreenState createState() => _WomenHarassScreenState();
}

class _WomenHarassScreenState extends State<WomenHarassScreen> {
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
  bool initval = false;
  @override
  void didChangeDependencies() {
    if (!initval) {}

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userid = Provider.of<Login>(context).userdat['name'];
    final contacts = Provider.of<Login>(context).emerContacts;

    return Scaffold(
      backgroundColor: Color(0xFFb6fbff),
      appBar: AppBar(
        backgroundColor: Color(0xFF83a4d4),
        automaticallyImplyLeading: false,
        title: Text("Women Harass ! Screen"),
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
                color: Color(0xFF83a4d4),
                topCardWidget: topCardWidget(
                    (snapshot.data)
                        ? 'assets/images/6.jpg'
                        : 'assets/images/10.jpg',
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
            'Put ON the GPS or Location ON so as to Track the Live Location of your mobile'
            '                                                                                '
            ' When someone tries to harass you or missbehave with you',
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
            Icons.local_police_rounded,
            color: Colors.white,
            size: 24.0,
          ),
          label: Text('Women Police Help'),
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
