import 'package:flutter/material.dart';
import 'package:template_api_practice/API_Service/product_model.dart';
import 'package:template_api_practice/UI_Material/detail_screen.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({super.key, required this.products});
  final ProductModel products;
  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(products: widget.products),
          ),
        );
      },
      child: ListTile(
        subtitle: Text(widget.products.name),
        title: Text(widget.products.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.products.image),
        ),
      ),
    );
  }
}
