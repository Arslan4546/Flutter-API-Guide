import 'dart:convert';
import 'package:covid19_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../../Models/WorldStatesModel.dart';

class StateServices {

  Future<WorldStatesModel> fetchWorldRecords()  async {

    final response = await http.get(Uri.parse(AppUrl.worldStatesList));

    if(response.statusCode==200){
         var data = jsonDecode(response.body.toString());
         return WorldStatesModel.fromJson(data);

    }else{
      throw Exception("Error");
    }

}



  Future<List<dynamic>> fetchCountriesRecord()  async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode==200){
       data = jsonDecode(response.body.toString());
      return data;

    }else{
      throw Exception("Error");
    }

  }
}