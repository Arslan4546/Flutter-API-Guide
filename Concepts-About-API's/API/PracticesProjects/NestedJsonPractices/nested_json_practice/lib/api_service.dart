import 'dart:convert';

import 'package:http/http.dart';
import 'package:nested_json_practice/product_model.dart';

class ApiService {
  static const url = "https://dummyjson.com/products";
  Future<List<Product>> getProductAPI() async {
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)["products"];
      return jsonList.map((e) => Product.fromMap(e)).toList();
    } else {
      throw Exception("failed");
    }
  }
}
