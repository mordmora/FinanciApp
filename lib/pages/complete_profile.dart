import 'dart:convert';
import 'dart:io';

import 'package:finanzas/components/labeled_input_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/models/user.dart';
import 'package:finanzas/providers/register_provider.dart';
import 'package:finanzas/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String _name = "";
  String _age = "";
  String _budgets = "";
  String terms = "0";
  bool isLoading = false;
  late SharedPreferences prefs;
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<bool> values = [true, false];

  saveIntoPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("name", _name);
    prefs.setString("age", _age);
    prefs.setString("budget", _budgets);
    prefs.setString("terms", terms);
  }

  late User user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _budgetsController = TextEditingController();

  @override
  void initState() {
    getSharedPreferences();
    _budgetsController.addListener(() {
      _budgets = _budgetsController.text;
    });
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    _ageController.addListener(() {
      _age = _ageController.text;
    });
    super.initState();
  }

  bool _validCredentials() {
    if (_name.isEmpty || _age.isEmpty || _budgets.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _budgetsController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _createUser() async {
      try {
        user = Provider.of<RegisterProvider>(context, listen: false)
            .createAccount(_name, _age, _budgets);
        saveIntoPrefs();
        var fullName = sliceFullName(user.name);
        Map<String, dynamic> data = {
          "first_name": fullName['firstName'],
          "last_name": fullName['lastName'],
          "budget": double.parse(user.ingresos),
          "term": int.parse(terms),
          "email":
              Provider.of<RegisterProvider>(context, listen: false).getEmail(),
          "password": Provider.of<RegisterProvider>(context, listen: false)
              .getPassword(),
        };
        print("i am here");
        print(jsonEncode(data));

        final Uri url =
            Uri.parse("http://financiapp.pythonanywhere.com/register");
        print("hop 1");
        var response = await http.post(url,
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));
        print("hop 2");
        print(response.statusCode.toString());
        if (response.statusCode == 200) {
          print(response.statusCode.toString());
          setState(() {});
          return true;
        } else {
          if (response.statusCode == 400) {
            String strResponse = jsonDecode(response.body)["error"];
            if (strResponse.isNotEmpty || strResponse.contains("error")) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "El email ya se encuentra registrado",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 15),
                ),
                backgroundColor: Palette.purple,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
                elevation: 4,
              ));
            }
          }
          print("error");
          setState(() {});
          return false;
        }
      } on SocketException catch (e) {
        setState(() {});
        print(e);
        return false;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              bottom: 0,
              child: Image(
                  image: AssetImage("lib/assets/images/wave-haikei.png"),
                  fit: BoxFit.fill),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Completa Tu Perfil",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 64,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person_add_alt_outlined,
                            size: 64,
                            color: Colors.grey,
                          )),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text(
                      "Sube una foto para personalizar mas tu perfli",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w100),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    LabeledTextField(
                      textInputType: TextInputType.name,
                      formatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z\s]+$'),
                            replacementString: _nameController.text),
                      ],
                      hintText: "Ej. Andrés Felipe",
                      label: "Nombre completo",
                      isPassword: false,
                      onChanged: (value) {
                        setState(() {});
                      },
                      borderColor: validName(_name) ? Colors.white : Colors.red,
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LabeledTextField(
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        LengthLimitingTextInputFormatter(2),
                      ],
                      label: "Edad",
                      textInputType: TextInputType.number,
                      hintText: "Ej. 46",
                      isPassword: false,
                      onChanged: (value) {
                        setState(() {});
                      },
                      borderColor: _age.isEmpty ? Palette.red : Colors.white,
                      controller: _ageController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LabeledTextField(
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        LengthLimitingTextInputFormatter(12),
                      ],
                      label: "Presupuesto",
                      textInputType: TextInputType.number,
                      hintText: "Ej. 2100000",
                      isPassword: false,
                      onChanged: (value) {
                        setState(() {});
                      },
                      borderColor:
                          _budgets.isEmpty ? Palette.red : Colors.white,
                      controller: _budgetsController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Duración del presupuesto",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w100),
                    ),
                    Row(children: [
                      Checkbox(
                        value: values[0],
                        onChanged: (item) {
                          values[0] = !values[0];
                          values[1] = false;
                          terms = "15";
                          setState(() {});
                          print(terms);
                        },
                      ),
                      const Text("15 dias",
                          style:
                              TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                      const SizedBox(
                        width: 20,
                      ),
                      Checkbox(
                        value: values[1],
                        onChanged: (item) {
                          values[0] = false;
                          values[1] = !values[1];
                          terms = "30";
                          setState(() {});
                          print(terms);
                        },
                      ),
                      const Text(
                        "30 dias",
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    ]),
                    Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(300, 50)),
                              backgroundColor: _validCredentials()
                                  ? MaterialStateProperty.all(
                                      Palette.purple,
                                    )
                                  : MaterialStateProperty.all(Colors.grey),
                            ),
                            onPressed: _validCredentials()
                                ? () {
                                    //Navigator.of(context)
                                    //    .pushNamedAndRemoveUntil(
                                    //        '/home', (route) => false);
                                    _createUser().then((value) {
                                      if (value) {
                                        print("Usuario creado");
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/home', (route) => false);
                                      } else {
                                        print("Error al crear usuario");
                                      }
                                    });
                                  }
                                : null,
                            child: const Text(
                              "Continuar",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white),
                            )))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
