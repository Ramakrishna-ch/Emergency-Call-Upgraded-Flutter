import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String accessToken;
  String tokenType;
  DateTime expiryTime;
  bool authen;
  Future<Map<String, String>> token() async {
    var checkval = await tryAutoAuthenticate();
    if (!checkval) {
      await authenticate();
    }
    return {'token': accessToken, 'type': tokenType};
  }

  Future<void> authenticate() async {
    final url = 'https://outpost.mapmyindia.com/api/security/oauth/token';
    final response = await http.post(url, headers: {
      'content-type': "application/x-www-form-urlencoded",
    }, body: {
      'grant_type': 'client_credentials',
      'client_id':
          '33OkryzDZsKkmYilQEbu9k6dfxstYq7wWW3Q4ICTkHXYAWrD5mnvbqmap54lKiNut94_usY9Tve0WGMDExjKCReM_D3rD2jSV9zaJMRFlCKxrHMsPTxDwg==',
      'client_secret':
          'lrFxI-iSEg9FfVgre0SdnFvhinR0KdWn6xxp9lWm4BKMPCyw2EHFbo6nRh9SOdAO2UHdMJ7EWiNiYhF31T9JOGwKhkro1kSFo1ybrqGiFg0tQ7L6WcVbTQZAotLc8rdp'
    });
    int statusCode = response.statusCode;
    print(statusCode / 100);
    if (statusCode / 100 == 2) {
      if (statusCode == 200) {
        final responseData = json.decode(response.body);
        accessToken = responseData['access_token'];
        tokenType = responseData['token_type'];
        notifyListeners();
        int expiryTime = responseData['expires_in'];
        final prefs = await SharedPreferences.getInstance();
        final tokenData = json.encode({
          'token_type': tokenType,
          'access_token': accessToken,
          'expiryTime': DateTime.now()
              .add(Duration(seconds: expiryTime))
              .toIso8601String(),
        });
        prefs.setString('MapToken', tokenData);
      }
    }
  }

  Future<bool> tryAutoAuthenticate() async {
    print('auto authenticate start');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('MapToken')) {
      print('auto authenticate key empty');

      return Future.value(false);
    }
    final extractedDataTokenData =
        json.decode(prefs.getString('MapToken')) as Map<String, Object>;
    print(extractedDataTokenData);
    expiryTime = DateTime.parse(extractedDataTokenData['expiryTime']);
    if (expiryTime.isBefore(DateTime.now())) {
      print('auto authenticate token expired');
      return Future.value(false);
    }

    tokenType = extractedDataTokenData['token_type'];
    accessToken = extractedDataTokenData['access_token'];
    notifyListeners();

    return Future.value(true);
  }
}
