import 'package:api_implementing/API_Service/model_class.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({super.key, required this.userData});
  final UserApi userData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userData.name),
      subtitle: Text(userData.email),
      leading: CircleAvatar(child: Text(userData.id.toString())),
    );
  }
}
