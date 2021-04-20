import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationClass with ChangeNotifier {
  var location = new Location();
  String userLocation;
  DateTime expiry;

  Future<void> getLocation() async {
    Map<String, double> currentLoc;
    try {
      currentLoc = await location.getLocation();
      userLocation = currentLoc['latitude'].toString() +
          ',' +
          currentLoc['longitude'].toString();
      expiry = DateTime.now();
      notifyListeners();
    } catch (e) {
      userLocation = null;
      notifyListeners();
    }
  }

  void showloc() {
    if (userLocation == null ||
        expiry == null ||
        !expiry.isAfter(DateTime.now().subtract(Duration(minutes: 2)))) {
      getLocation();
    }
  }
}
