// ignore: file_names
import 'package:finanzas/pages/complete_profile.dart';
import 'package:finanzas/pages/confirmation_recovery.dart';
import 'package:finanzas/pages/forgot_password.dart';
import 'package:finanzas/pages/login_page.dart';
import 'package:finanzas/pages/new_account.dart';

import '../pages/entry_point.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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
      default:
        return MaterialPageRoute(builder: (context) => const EntryPoint());
    }
  }
}
