import 'dart:convert';

import 'package:finanzas/models/budgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BudgetProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  Future<List> addBudget(Budget budget) async {
    prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    try {
      final response = await http.post(
          Uri.parse(
              'http://financiapp.pythonanywhere.com/users/createTransaction'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(budget.toJson()));

      return [response.statusCode, jsonDecode(response.body)];
    } catch (e) {
      return [
        500,
        {"message": "Fallo en la conexión"}
      ];
    }
  }
}
