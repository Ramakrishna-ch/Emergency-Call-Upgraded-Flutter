import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../rest/auth.dart';

class GetData {
  Future<void> getPlaces(
      String tokenType1, String accessToken1, String locationdat) async {
    print(tokenType1);
    print(accessToken1);
    final url =
        'https://atlas.mapmyindia.com/api/places/nearby/json?keywords=police&refLocation=12.800930,80.223935';

    final response = await http.get(
      url,
      headers: {
        'content-type': "application/x-www-form-urlencoded",
        'Authorization': "$tokenType1 $accessToken1",
      },
    );

    print(response.body);
  }
}
