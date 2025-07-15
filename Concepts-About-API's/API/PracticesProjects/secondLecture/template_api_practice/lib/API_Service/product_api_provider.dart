import 'package:template_api_practice/API_Service/api_service.dart';
import 'package:template_api_practice/API_Service/product_model.dart';

class ProductApiProvider extends ApiService {
  @override
  String get apiURL => "/products";

  // fetchProductAPI function

  Future<List<ProductModel>> fetchProductAPI() async {
    List<dynamic> jsonList = await fetchAPI();
    return jsonList.map((map) => ProductModel.fromMap(map)).toList();
  }

  // fetchProductAPIBySingleID function

  Future<ProductModel> fetchProductAPIBySingleID(String endPoint) async {
    var data = await fetchAPIBySingleID(endPoint);
    return ProductModel.fromMap(data);
  }

  // insertProductAPI function
  Future<bool> insertProductAPI(ProductModel productModel) async {
    return insertAPI(productModel.toMap());
  }

  // updateProductAPI function
  Future<bool> updateProductAPI(ProductModel productModel) async {
    return updateAPI("${productModel.id}", productModel.toMap());
  }

  // deleteProductAPI function
  Future<bool> deleteProductAPI(ProductModel productModel) async {
    return updateAPI("${productModel.id}", productModel.toMap());
  }
}
