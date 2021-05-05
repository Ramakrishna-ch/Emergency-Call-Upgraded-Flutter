import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../rest/auth.dart';

class GetData with ChangeNotifier {
  var contents;
  var contents1;
  Future<Map<String, dynamic>> getPlaces(
      String tokenType1, String accessToken1, String locationdat) async {
    print(tokenType1);
    print(accessToken1);
    final url =
        'https://atlas.mapmyindia.com/api/places/nearby/json?keywords=police&refLocation=$locationdat';

    final response = await http.get(
      url,
      headers: {
        'content-type': "application/x-www-form-urlencoded",
        'Authorization': "$tokenType1 $accessToken1",
      },
    );

    // contents = json.decode(response.body)["suggestedLocations"][0]['eLoc'];
    final sample = json.decode(response.body);
    print(sample);
    contents = sample["suggestedLocations"][0]['eLoc'];

    contents1 = sample["suggestedLocations"][0]['placeAddress'];

    var desmap = {'eloc': contents, 'points': contents1};
    notifyListeners();
    return desmap;
  }
}
