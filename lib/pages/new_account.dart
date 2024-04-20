import 'package:finanzas/components/labeled_input_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/providers/register_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  String _email = "";
  String _password = "";
  String _repeatPassword = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  @override
  void initState() {
    _emailController.addListener(() {
      _email = _emailController.text;
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
    _repeatPasswordController.addListener(() {
      _repeatPassword = _repeatPasswordController.text;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  bool _validCredentials() {
    if (_email.isEmpty ||
        _password.isEmpty ||
        _repeatPassword.isEmpty ||
        !_validEmail()) {
      return false;
    }

    return _password == _repeatPassword;
  }

  bool _validEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }

  @override
  Widget build(BuildContext context) {
    RegisterProvider loginProvider = Provider.of<RegisterProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "lib/assets/images/wave-haikei.png",
                  color: Palette.green,
                  fit: BoxFit.fill,
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Regístrate',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      const Text("Crea una cuenta ahora",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              letterSpacing: 0.2)),
                      const SizedBox(height: 10),
                      LabeledTextField(
                          borderColor:
                              _validEmail() ? Colors.white : Palette.red,
                          label: "Email",
                          isPassword: false,
                          controller: _emailController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          formatter: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            FilteringTextInputFormatter.deny(
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{,}$'))
                          ]),
                      const SizedBox(height: 10),
                      LabeledTextField(
                        borderColor: _password == _repeatPassword
                            ? Colors.white
                            : Palette.red,
                        label: "Contraseña",
                        isPassword: true,
                        controller: _passwordController,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 10),
                      LabeledTextField(
                          borderColor: _password == _repeatPassword
                              ? Colors.white
                              : Palette.red,
                          label: "Confirmar contraseña",
                          isPassword: true,
                          controller: _repeatPasswordController,
                          onChanged: (value) {
                            setState(() {});
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                            disabledColor: Colors.grey,
                            padding: const EdgeInsets.all(0),
                            color: Palette.purple,
                            borderRadius: BorderRadius.circular(30),
                            onPressed: _validCredentials()
                                ? () {
                                    loginProvider.setEmail(_email);
                                    loginProvider.setPassword(_password);
                                    Navigator.pushNamed(
                                        context, '/completeProfile');
                                  }
                                : null,
                            child: _validCredentials()
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              134, 126, 126, 126),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          blurStyle: BlurStyle.normal,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Palette.purple,
                                    ),
                                    child: const Text('Crear cuenta',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              134, 126, 126, 126),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          blurStyle: BlurStyle.normal,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey,
                                    ),
                                    child: const Text('Crear cuenta',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  )),
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.arrow_back,
                                  color: Palette.purple),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Iniciar sesión",
                                  style: TextStyle(
                                    fontSize: width * 0.035,
                                    fontFamily: 'Poppins',
                                    color: Palette.purple,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text("¿Ya tienes una cuenta?",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: width * 0.035,
                                  ))
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
