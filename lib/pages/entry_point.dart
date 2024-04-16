import 'package:finanzas/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  late SharedPreferences prefs;
  bool _isLogged = true;

  readSharedPrefs() {
    setState(() {
      _isLogged = prefs.getBool('isLogged') ?? true;
    });
  }

  getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveSharedPrefs() {
    prefs.setBool('isLogged', false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
