import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dataModel/wordMeaningDataModel.dart';

class ApiController{
  static const String baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  static Future<WordMeaningDataModel> fetchWordMeaning(String word) async{
    final response = await http.get(Uri.parse("$baseURL$word"));
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print(data);
      return WordMeaningDataModel.fromJson(data[0]);
    }
    else{

      throw Exception("Failed to load meaning");
    }
  }
}