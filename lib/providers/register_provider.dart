import 'package:finanzas/models/user.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
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

  User createAccount(String nombre, String edad, String ingresos) {
    User user = User(name: nombre, age: "", ingresos: ingresos);
    return user;
  }

  Future<void> createUser() async {}
}
