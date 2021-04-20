import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_test/main.dart';
import 'package:provider/provider.dart';

class Login with ChangeNotifier {
  String _userid;
  String _type;
  final Map<String, String> userdat = Map<String, String>();
  List<String> emerContacts = [];
  String get userid {
    return _userid;
  }

  bool get isauth {
    return _userid != null;
  }

  String get type {
    return _type;
  }

  List<String> get emer {
    return [...emerContacts];
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
      extractedData.forEach((key, value) => userdat[key] = value?.toString());
      emerContacts.clear();
      emerContacts.addAll(userdat['emercontacts'].split(" "));
      userdat.remove('emercontacts');
      // userdat = extractedData as Map<String, String>;
      // // extracteduserdata['userid'] = _mainid['userid'];
      notifyListeners();
      print('test');
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
            'auto': 'true',
            'lastlogin': logtime,
          }));
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'type': type,
        'userid': id['userid'],
        'password': id['password'],
      });
      prefs.setString('tokenData', tokenData);
      _userid = id['userid'];
      _type = type;
      userdat['userid'] = _userid;
      print(_type);
      if (_type == 'email') {
        String sample = _userid.replaceAll('gmailcom', '@gmail.com');
        userdat['userid'] = sample;
      }
      userdat['password'] = userdat['cfnpass'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkuser() async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/";
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tokenData')) {
      print('token data');
      final extractedDataTokenData =
          json.decode(prefs.getString('tokenData')) as Map<String, Object>;
      print(extractedDataTokenData);

      final response = await http.get(url +
          "${extractedDataTokenData['type']}/${extractedDataTokenData['userid']}.json");
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
        await http.patch(
            url +
                "${extractedDataTokenData['type']}/${extractedDataTokenData['userid']}.json",
            body: json.encode({
              'lastlogin': DateTime.now().toIso8601String(),
            }));
        _userid = extractedDataTokenData['userid'];
        _type = extractedDataTokenData['type'];
        extractedData.forEach((key, value) => userdat[key] = value?.toString());
        emerContacts.clear();
        emerContacts.addAll(userdat['emercontacts'].split(" "));
        userdat.remove('emercontacts');
        userdat.remove('auto');
        userdat.remove('lastlogin');
        userdat['userid'] = _userid;
        print(_type);
        if (_type == 'email') {
          String sample = _userid.replaceAll('gmailcom', '@gmail.com');
          userdat['userid'] = sample;
        }

        userdat['password'] = userdat['cfnpass'];
        notifyListeners();
        print(emerContacts);
        // extracteduserdata = extractedData;
        // extracteduserdata['userid'] = _mainid['userid'];
        // extracteduserdata['password'] = extractedDataTokenData['password'];

        // print(extracteduserdata);
        return true;
      } else {
        print('wrong');
        return false;
      }
    } else {
      print('no token');

      return false;
    }
  }

  Future<void> logout() async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$_type/$_userid.json";
    try {
      final response =
          await http.patch(url, body: json.encode({'auto': "false"}));
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('tokenData');
      _userid = null;
      _type = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> editDetails(String type, Map<String, String> details) async {
    String id = details['userid'];
    details.remove('userid');
    details.remove('password');
    print(details);
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.patch(url, body: json.encode(details));
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'type': type,
        'userid': id,
        'password': details['cfnpass'],
      });
      prefs.setString('tokenData', tokenData);
      _userid = id;
      _type = type;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> editContacts(String contacts) async {
    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$_type/$_userid.json";
    try {
      final response =
          await http.patch(url, body: json.encode({'emercontacts': contacts}));
    } catch (e) {
      throw (e);
    }
  }
}
