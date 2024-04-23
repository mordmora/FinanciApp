import 'dart:convert';

import 'package:finanzas/models/logged_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  String token = "";

  Future<String> loginUser(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse('http://financiapp.pythonanywhere.com/login');
    try {
      Map<String, String> data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        if (response.body.contains("token")) {}
        String token = jsonDecode(response.body)["token"];
        prefs.setString("token", token);
        return token;
      } else {
        String error = jsonDecode(response.body)["message"];
        return error;
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<String> getUserData() async {
    try {
      Uri url = Uri.parse('http://financiapp.pythonanywhere.com/users/getData');
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          LoggedUser loggedUser =
              LoggedUser.fromJson(jsonDecode(response.body));
          prefs.setString('firstName', loggedUser.firstName);
          prefs.setString('lastName', loggedUser.lastName);
          prefs.setString('budget', loggedUser.defaultBudget.toString());
          return loggedUser.firstName;
        } else {
          return 'error: respuesta vacía';
        }
      } else {
        return 'error ${response.body}';
      }
    } catch (e) {
      return 'error $e';
    }
  }
}
