import 'package:flutter/material.dart';

import '../model/UserRegisterationModel.dart';
import '../services/UserService.dart';


class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userData => _userData;

  Future<void> registerUser(UserRegistrationModel user) async {
    _isLoading = true;
    notifyListeners();

    final result = await _userService.registerUser(user);

    if (result.containsKey('error')) {
      _errorMessage = result['error'];
    } else {
      _userData = result; // Store user data upon success
      _errorMessage = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
