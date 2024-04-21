import 'dart:convert';

import 'package:finanzas/components/action_button.dart';
import 'package:finanzas/components/input_field.dart';
import 'package:finanzas/components/password_input_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() {
      _email = _emailController.text;
    });

    _passwordController.addListener(() {
      _password = _passwordController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> loginUser(String email, String password) async {
    Uri url = Uri.parse('http://financiapp.pythonanywhere.com/login');
    try {
      Map<String, String> data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)["token"];
        return token;
      } else {
        String error = jsonDecode(response.body)["message"];
        return error;
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        backgroundColor: Palette.purple,
        title: const Text(
          'Financi App',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Palette.bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  'lib/assets/images/wave-haikei.png',
                ),
                color: Palette.green),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenido',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                  ),
                  CustomInputField(
                    controller: _emailController,
                    height: 70,
                    color: Colors.white,
                    labelText: 'Email',
                    hintText: 'Ingresa tu email',
                  ),
                  CustomPasswordInputField(
                    controller: _passwordController,
                    height: 70,
                    color: Colors.white,
                    labelText: 'Contraseña',
                    hintText: 'Ingresa tu contraseña',
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .loginUser(_email, _password)
                          .then((value) {
                        Navigator.pushNamed(context, '/home');
                      });
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8.0),
                              child: Text("No tienes una cuenta aún?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w200)),
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Row(
                                  children: [
                                    Text("Crear",
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Icon(Icons.arrow_forward_rounded)
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/newAccount');
                                })
                          ],
                        )),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
