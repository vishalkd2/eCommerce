class UserRegistrationModel {
  final String name;
  final String email;
  final String password;
  final String avatar;

  UserRegistrationModel({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  // Convert JSON to UserRegistrationModel
  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
    );
  }

  // Convert UserRegistrationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
}
