import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetDetails {
  Future<void> fetchDat(String place_id) async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authority/$place_id.json";

    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    print(extractedData);
  }
}
