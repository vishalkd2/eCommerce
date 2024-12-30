

class LoginResponseModel{
  final String accessToken;
  LoginResponseModel({required this.accessToken});

  factory LoginResponseModel.fromJson(Map<String,dynamic>json){
    return LoginResponseModel(accessToken: json['access_token']);
  }

  Map<String,dynamic>toJson(){
    return{
      'access_token':accessToken
    };
  }
}