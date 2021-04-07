import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Login {
  Future<void> loginuser(Map<String, String> logindat, String type) async {
    final id = logindat['userid'];
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        throw ('Email or Phone doesn\'t exists');
      } else if (extractedData['cfnpass'] != logindat['password']) {
        throw ('Wrong password');
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> timeupdate(String autosav, String type, String id) async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.patch(url,
          body: json.encode({
            'auto': autosav,
            'lastlogin': DateTime.now().toIso8601String()
          }));
    } catch (e) {
      print(e);
    }
  }
}
