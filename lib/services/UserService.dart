import 'dart:convert';
import 'package:ecommerce/model/LoginResponseModel.dart';
import 'package:http/http.dart' as http;
import '../model/UserRegisterationModel.dart';

class UserService {
  final String baseUrl = "https://api.escuelajs.co/api/v1/users/";
  static const String loginUrl="https://api.escuelajs.co/api/v1/auth/login";

  Future<Map<String, dynamic>> registerUser(UserRegistrationModel user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        print(response.body);
        // Successfully registered
        return json.decode(response.body);
      } else {
        // Registration failed
        return {'error': 'Failed to register user. Please try again.'};
      }
    } catch (e) {
      // Error handling
      return {'error': 'Something went wrong. Please try again.'};
    }
  }

  Future<LoginResponseModel> login(String email,String password)async{
    final response =await http.post(Uri.parse(loginUrl),
        headers: {'Content-Type':'application/json'},
    body: json.encode({'email':email, 'password':password }));
    if(response.statusCode==201){
      print("you are logged in successfully");
      return LoginResponseModel.fromJson(json.decode(response.body));
    }else{
      throw Exception("Login failed");
    }
  }
}
