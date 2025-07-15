import 'package:flutter/material.dart';
import 'package:template_api_practice/API_Service/product_api_provider.dart';
import 'package:template_api_practice/API_Service/product_model.dart';
import 'package:template_api_practice/UI_Material/list_builder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductApiProvider productApiProvider = ProductApiProvider();
  Future<List<ProductModel>>? _futureProductList;
  Future<ProductModel>? _singleProduct;

  @override
  void initState() {
    super.initState();
    _futureProductList = productApiProvider.fetchProductAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _futureProductList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListBuilderWidget(productList: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
