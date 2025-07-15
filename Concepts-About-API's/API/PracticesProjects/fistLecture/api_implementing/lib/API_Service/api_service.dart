import 'dart:convert';

import 'package:api_implementing/API_Service/model_class.dart';
import 'package:http/http.dart';

// extension function for checking the response status code

extension ResponseExtension on Response {
  bool get isSuccessfull => statusCode == 200 || statusCode == 201;
}

class ApiService {
  // Base URL for the API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  // APi Url for implementing API
  static const String apiUrl = '/users';
  // final url for implemting API
  String get url => baseUrl + apiUrl;

  // Funciton for getting List of Map from the API
  Future<List<UserApi>> getAlbums() async {
    var response = await get(Uri.parse(url));
    if (response.isSuccessfull) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((map) => UserApi.fromMap(map)).toList();
    } else {
      throw Exception('Failed to load albums : ${response.statusCode}');
    }
  }

  // Function for getting single entery by giving just id
  Future<UserApi> getAlbumById(int id) async {
    var response = await get(Uri.parse('$url/$id'));
    if (response.isSuccessfull) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UserApi.fromMap(map);
    } else {
      throw Exception('Failed to load album : ${response.statusCode}');
    }
  }

  // function for deleting the album by id
  // Future<bool> deleteAlbum(AlbumApi album) async {
  //   var response = await delete(
  //     Uri.parse('$url/${album.id}'),
  //     body: album.toJson(),
  //   );
  //   if (response.isSuccessfull) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to delete album : ${response.statusCode}');
  //   }
  // }

  // function for inserting the new album
  // Future<bool> insertAlbum(AlbumApi album) async {
  //   var response = await post(Uri.parse(url), body: album.toJson());
  //   if (response.isSuccessfull) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to delete album : ${response.statusCode}');
  //   }
  // }

  // function for updating the album by id
  // Future<bool> updateAlbum(AlbumApi album) async {
  //   var response = await put(
  //     Uri.parse('$url/${album.id}'),
  //     body: album.toJson(),
  //   );
  //   if (response.isSuccessfull) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to delete album : ${response.statusCode}');
  //   }
  // }
}
