import 'dart:convert';

import 'package:http/http.dart'as http;

class UserService{
  Future<void> login(String email,String password)async{
    try{
      final response=await http.post(Uri.parse("https://reqres.in/api/login"),body: {'email':email,'password':password});
      if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data['token']);
        print("Login Successfully");
      }else{
        print("Failed du to error");
      }
    }catch(e){
      print("Error is :${e.toString()}");
    }
  }
}