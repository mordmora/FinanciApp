import 'dart:convert';

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
        String token = jsonDecode(response.body)["token"];
        prefs.setString("token", token);
        print(prefs.getString("token"));
        return token;
      } else {
        String error = jsonDecode(response.body)["message"];
        return error;
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
