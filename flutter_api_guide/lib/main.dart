import 'package:flutter/material.dart';
import 'package:flutter_api_guide/Views/Complex_Json_With_Extension/complex_json_using_extension.dart';
import 'package:flutter_api_guide/Views/Create_Custom_Model_With_GetAPI/custom_model_screen.dart';
import 'package:flutter_api_guide/Views/Simple_GetAPI_with_Posts_Model/simple_post_api_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: SimplePostApiScreen(),
      //home: CustomModelScreen(),
      home: ComplexJsonUsingExtension(),
    );
  }
}
