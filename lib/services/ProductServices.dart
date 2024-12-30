
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:ecommerce/model/CategoryModel.dart';

class ProductServices{
  static const String catogryUrl="https://api.escuelajs.co/api/v1/categories";

  static Future<List<CategoryModel>> fetchCategogy()async{
    final response= await http.get(Uri.parse(catogryUrl));
    if(response.statusCode==200){
      List<dynamic>jsonData=json.decode(response.body);
      return jsonData.map((json)=>CategoryModel.fromJson(json)).toList();
    }else{
      throw Exception("Failed to load categogy");
    }
  }
}