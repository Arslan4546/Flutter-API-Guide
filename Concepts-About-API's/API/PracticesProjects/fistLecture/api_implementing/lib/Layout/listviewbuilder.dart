import 'package:api_implementing/API_Service/model_class.dart';
import 'package:api_implementing/Layout/listTile.dart';
import 'package:flutter/material.dart';

class ListviewbuilderWidget extends StatelessWidget {
  ListviewbuilderWidget({super.key, required this.userList});
  List<UserApi> userList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return ListTileWidget(userData: userList[index]);
      },
    );
  }
}
