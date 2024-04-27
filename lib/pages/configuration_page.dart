import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void deletePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Configuraciones",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 27),
        ),
      ),
      backgroundColor: Palette.bg,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: CupertinoButton(
              color: Palette.purple,
              onPressed: () {
                deletePrefs();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text(
                "Cerrar sesión",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Poppins', fontSize: 20),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
