import 'package:flutter/material.dart';
import 'package:flutter_api_guide/Views/Get_API/Complex_Json_With_Extension/complex_json_using_extension.dart';
import 'package:flutter_api_guide/Views/Get_API/Complex_Json_witStarting_with_Object/withoutStartingListButObject.dart';
import 'package:flutter_api_guide/Views/Get_API/Create_Custom_Model_With_GetAPI/custom_model_screen.dart';
import 'package:flutter_api_guide/Views/Get_API/If_Model_Not_Possible/model_not_possible.dart';
import 'package:flutter_api_guide/Views/Get_API/Simple_GetAPI_with_Posts_Model/simple_post_api_screen.dart';

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
      //home: ComplexJsonUsingExtension()
      // home: ModelNotPossible(),
      home: Withoutstartinglistbutobject(),
    );
  }
}
