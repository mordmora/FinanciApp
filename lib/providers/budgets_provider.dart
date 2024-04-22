import 'dart:convert';

import 'package:finanzas/models/budgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BudgetProvider extends ChangeNotifier {
  Future<String> addBudget(Budget budget, String token) async {
    try {
      final response = await http.post(
          Uri.parse(
              'http://financiapp.pythonanywhere.com/users/createTransaction'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(budget.toJson()));
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print("Error");
        print(response.body);
        return "Error";
      }
    } catch (e) {
      print(e.toString());
      return "Error";
    }
  }
}
