import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_test/main.dart';
import 'package:provider/provider.dart';

class Login with ChangeNotifier {
  Map<String, String> _mainid = {'userid': '', 'type': ''};
  Map<String, String> get getid {
    return _mainid;
  }

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
      _mainid['userid'] = id;
      _mainid['type'] = type;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> timeupdate(
      String autosav, String type, Map<String, String> id) async {
    String logtime = DateTime.now().toIso8601String();
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/${id['userid']}.json";
    try {
      final response = await http.patch(url,
          body: json.encode({
            'auto': autosav,
            'lastlogin': logtime,
          }));
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'type': type,
        'userid': id['userid'],
        'password': id['password'],
      });
      prefs.setString('tokenData', tokenData);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkuser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tokenData')) {
      print('token data');
      final extractedDataTokenData =
          json.decode(prefs.getString('tokenData')) as Map<String, Object>;
      print(extractedDataTokenData);
      var url =
          "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/${extractedDataTokenData['type']}/${extractedDataTokenData['userid']}.json";

      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        print('null return');
        return false;
      } else if (extractedData['cfnpass'] ==
              extractedDataTokenData['password'] &&
          extractedData['auto'] == 'true' &&
          DateTime.parse(extractedData['lastlogin'])
              .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
        print('right');
        _mainid['userid'] = extractedDataTokenData['userid'];
        _mainid['type'] = extractedDataTokenData['type'];
        notifyListeners();
        return true;
      } else {
        print('wrong');
        return false;
      }
    }
    print('no token');
    return false;
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('tokenData');
      var url =
          "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/${_mainid['type']}/${_mainid['userid']}.json";

      final response = await http.patch(url,
          body: json.encode({
            'auto': 'false',
          }));
    } catch (e) {
      print(e);
    }
  }
}
