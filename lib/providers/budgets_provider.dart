import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  double _budget = 0.0;

  double get budget => _budget;
}
