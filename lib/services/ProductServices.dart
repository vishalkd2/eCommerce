
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:ecommerce/model/CategoryModel.dart';
import '../model/ProductListModel.dart';

class ProductServices{
  static Future<List<CategoryModel>> fetchCategory()async{
    final response =  await http.get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
    if(response.statusCode==200){
      List<dynamic> jsonData=json.decode(response.body);
      List<CategoryModel> categories = jsonData.map((json) => CategoryModel.fromJson(json)).toList();
      return categories;
    }else{
      throw Exception("Failed to load data");
    }
  }

  static Future<List<ProductListModel>> fetchProduct()async{
    final response=await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
    if(response.statusCode==200){
      List<dynamic> jsonData=jsonDecode(response.body);
      List<ProductListModel> productList= jsonData.map((json) => ProductListModel.fromJson(json)).toList();
      return productList;
    }else{
      throw Exception("Failed to load data");
    }
  }
}