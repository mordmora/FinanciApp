import 'package:finanzas/components/sucess_button.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/material.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final TextEditingController _emailController = TextEditingController();
  String email = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.bg,
      appBar: AppBar(
          backgroundColor: Palette.bg,
          title: const Text(
            "Recuperar contraseña",
            style: TextStyle(
                fontFamily: 'Poppins',
                letterSpacing: BorderSide.strokeAlignInside),
          ),
          centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text(
                "Ingresa el correo asociado a tu cuenta, si este existe recibirás instrucciones para recuperar la contraseña.",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    letterSpacing: BorderSide.strokeAlignInside,
                    fontWeight: FontWeight.w100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = _emailController.text;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Correo electronico',
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  letterSpacing: BorderSide.strokeAlignInside),
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SucessButton(
              route: '/recovery/confirmation',
            )
          ]),
          Image.asset('lib/assets/images/wave-haikei.png',
              fit: BoxFit.fill, color: Palette.green)
        ],
      ),
    );
  }
}
