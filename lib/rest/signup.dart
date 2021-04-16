import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Signup {
  Future<void> checkid(String type, String id) async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);

      if (extractedData != null) {
        throw (NullThrownError);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signupuser(Map<String, String> userDat, String type) async {
    final id = userDat['userid'];
    userDat.remove('userid');
    userDat.remove('password');
    userDat.addAll({
      'auto': 'false',
      'lastlogin': '',
      'emercontacts': userDat['emergency'] + " " + userDat['contact'],
    });
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.put(url, body: json.encode(userDat));
      if (response.statusCode != 200) {
        throw (response.reasonPhrase);
      }
    } catch (e) {
      throw (e);
    }
  }
}
