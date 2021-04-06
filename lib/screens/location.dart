import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:sms_test/rest/auth.dart';
import '../rest/getdata.dart';
import '../rest/getDetails.dart';

class GetLocationPage extends StatefulWidget {
  static const routeName = '/GetLocationPage';
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  var location = new Location();
  Auth auth = Auth();

  Map<String, double> userLocation;
  GetData getdat = GetData();

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    userLocation["latitude"].toString() +
                    " " +
                    userLocation["longitude"].toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(data['tokenType']);
                final String locdat = userLocation['latitude'].toString() +
                    ',' +
                    userLocation['longitude'].toString();
                getdat.getPlaces(
                    data['tokenType'], data['accessToken'], locdat);
              },
              child: Text('Get Data'),
            ),
            ElevatedButton(
              onPressed: () {
                GetDetails getplace = GetDetails();
                final place = getdat.copycontent();
                getplace.fetchDat(place);
              },
              child: Text('copy'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
