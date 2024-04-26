// ignore: file_names
import 'package:finanzas/pages/add_movement.dart';
import 'package:finanzas/pages/complete_profile.dart';
import 'package:finanzas/pages/configuration_page.dart';
import 'package:finanzas/pages/confirmation_recovery.dart';
import 'package:finanzas/pages/forgot_password.dart';
import 'package:finanzas/pages/graphics.dart';
import 'package:finanzas/pages/home_page.dart';
import 'package:finanzas/pages/login_page.dart';
import 'package:finanzas/pages/my_budgets.dart';
import 'package:finanzas/pages/new_account.dart';

import '../pages/entry_point.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const EntryPoint());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/recovery/Password':
        return MaterialPageRoute(builder: (context) => const RecoverPassword());
      case '/recovery/confirmation':
        return MaterialPageRoute(
            builder: (context) => const ConfirmationRecovery());
      case '/newAccount':
        return MaterialPageRoute(builder: (context) => const NewAccount());
      case '/completeProfile':
        return MaterialPageRoute(builder: (context) => const CompleteProfile());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/addMovement':
        return MaterialPageRoute(
            builder: (context) =>
                AddMovement(type: settings.arguments.toString()));
      case '/myBudgets':
        return MaterialPageRoute(builder: (context) => const Mybudgets());
      case '/settings':
        return MaterialPageRoute(builder: (context) => const SettingsPage());
      case '/graphics':
        return MaterialPageRoute(builder: (context) => const Graphics());
      default:
        return MaterialPageRoute(builder: (context) => const EntryPoint());
    }
  }
}
