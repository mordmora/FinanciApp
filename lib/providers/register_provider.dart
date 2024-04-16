import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String? email;
  String? password;

  String getEmail() {
    return email ?? "";
  }

  String get getPasssword => password ?? "";
  String get getEmmmail => email ?? "";

  String getPassword() {
    return password ?? "";
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }
}
