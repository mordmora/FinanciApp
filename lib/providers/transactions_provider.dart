import "dart:convert";
import 'package:finanzas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<List<Transaction>> getTransactionsNow() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";
      Uri url =
          Uri.parse('http://financiapp.pythonanywhere.com/users/getBudgetNow');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        List<Transaction> trans = [];
        for (var item in (jsonDecode(response.body)["transactions"] as List)) {
          trans.insert(0, Transaction.fromJson(item));
        }
        return trans;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> getBudget() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";
      Uri url =
          Uri.parse('http://financiapp.pythonanywhere.com/users/getBudgetNow');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        String budget = jsonDecode(response.body)["budget"].toString();
        return "\$$budget";
      } else {
        print(jsonDecode(response.body)["message"]);
        return "\$0.00";
      }
    } catch (e) {
      return "Error al obtener los datos";
    }
  }
}
