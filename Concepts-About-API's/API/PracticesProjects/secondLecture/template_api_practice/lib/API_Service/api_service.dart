import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';

extension ResponseExtension on Response {
  bool get isSuccessfull => statusCode == 200 || statusCode == 201;
}

abstract class ApiService {
  static const baseURL = "https://dummyjson.com";
  String get apiURL;
  String get url => baseURL + apiURL;

  // fetch API Data
  Future<dynamic> fetchAPI() async {
    var response = await get(Uri.parse(url));
    if (response.isSuccessfull) {
      var data = jsonDecode(response.body);
      return data["products"];
    }
  }

  // fetch API Data By Single ID
  Future<dynamic> fetchAPIBySingleID(String endPoint) async {
    var response = await get(Uri.parse("$url/$endPoint"));
    if (response.isSuccessfull) {
      return jsonDecode(response.body);
    }
  }

  // insert API Function
  Future<bool> insertAPI(Map<String, dynamic> map) async {
    var response = await post(Uri.parse(url), body: map);
    return response.isSuccessfull;
  }

  // update API Function
  Future<bool> updateAPI(String endPoint, Map<String, dynamic> map) async {
    var response = await post(Uri.parse("$url/$endPoint"), body: map);
    return response.isSuccessfull;
  }

  // update API Function
  Future<bool> deleteAPI(String endPoint, Map<String, dynamic> map) async {
    var response = await post(Uri.parse("$url/$endPoint"), body: map);
    return response.isSuccessfull;
  }
}
