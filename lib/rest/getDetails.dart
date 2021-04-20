import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetDetails with ChangeNotifier {
  Map<String, String> authorityData = Map<String, String>();
  Future<void> fetchDat(String place_id) async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authority/$place_id.json";

    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    extractedData
        .forEach((key, value) => authorityData[key] = value?.toString());
    notifyListeners();
  }
}
