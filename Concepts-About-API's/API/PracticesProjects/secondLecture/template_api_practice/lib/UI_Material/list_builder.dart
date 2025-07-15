import 'package:flutter/material.dart';
import 'package:template_api_practice/API_Service/product_model.dart';
import 'package:template_api_practice/UI_Material/list_tile.dart';

class ListBuilderWidget extends StatelessWidget {
  const ListBuilderWidget({super.key, required this.productList});
  final List<ProductModel> productList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ListTileWidget(products: productList[index]);
      },
    );
  }
}
