import 'dart:convert';
import 'package:http/http.dart';

// Extension method for checing status code
extension ResponseStatus on Response {
  bool get isSuccessfull => statusCode == 200 || statusCode == 201;
}

// class for API Service
abstract class ApiService {
  // Making baseAPI Variable
  static const String baseURl = "https://jsonplaceholder.typicode.com";
  // abstract Variable apiURL
  String get apiURL;
  // This is the resultant Variable url
  String get url => baseURl + apiURL;

  // fetch API Function / OR
  Future<dynamic> fetchAPI() async {
    var response = await get(Uri.parse(url));
    if (response.isSuccessfull) {
      return jsonDecode(response.body);
    }
  }

  // fetchSingleID API Function by Single ID
  Future<dynamic> fetchSingleAPI(String endPoint) async {
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
    var response = await put(Uri.parse("$url/$endPoint"), body: map);
    return response.isSuccessfull;
  }

  // delete API Function
  Future<bool> deleteAPI(String endPoint, Map<String, dynamic> map) async {
    var response = await delete(Uri.parse("$url/$endPoint"), body: map);
    return response.isSuccessfull;
  }
}
