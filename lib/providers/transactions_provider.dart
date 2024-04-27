import "dart:convert";
import 'package:finanzas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<Set<Transaction>> getTransactionsNow() async {
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
        Set<Transaction> trans = {};
        for (var item in (jsonDecode(response.body)["transactions"] as List)) {
          trans.add(Transaction.fromJson(item));
        }
        return trans;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";
      Uri url = Uri.parse(
          'http://financiapp.pythonanywhere.com/users/deleteTransaction/$id');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
      } else {}
      // ignore: empty_catches
    } catch (e) {}
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
        return "\$0.00";
      }
    } catch (e) {
      return "Error al obtener los datos";
    }
  }

  Future<Map<String, dynamic>> getGraphicData() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";
      Uri url = Uri.parse(
        'http://financiapp.pythonanywhere.com/users/getGraphicData',
      );

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<double> gastos = jsonResponse['gastos'].cast<double>();
        List<double> ingresos = jsonResponse['ingresos'].cast<double>();
        List<String> labels = jsonResponse['labels'].cast<String>();
        double maxG = jsonResponse['max_g'];
        double maxI = jsonResponse['max_i'];
        return {
          'gastos': gastos,
          'ingresos': ingresos,
          'labels': labels,
          'maxG': maxG,
          'maxI': maxI,
        };
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
