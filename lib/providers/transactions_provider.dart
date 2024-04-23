import "dart:convert";
import 'package:finanzas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finanzas/components/transaction_component.dart';

class TransactionsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<List> getTransactionsNow() async {
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
        List trans = jsonDecode(response.body)["transactions"];
        return trans;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
