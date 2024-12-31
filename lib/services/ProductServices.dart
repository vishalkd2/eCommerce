
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:ecommerce/model/CategoryModel.dart';

class ProductServices{


  static Future<List<CategoryModel>> fetchCategory()async{
    final response =  await http.get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
    if(response.statusCode==200){
      print(response.body.toString());
      List<dynamic> jsonData=json.decode(response.body);
      return jsonData.map((json)=>CategoryModel.fromJson(json)).toList();
    }else{
      throw Exception("Failed to load data");
    }
  }

}