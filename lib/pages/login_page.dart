import 'package:finanzas/components/input_field.dart';
import 'package:finanzas/components/password_input_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Image(
                  image: AssetImage(
                    'lib/assets/images/wave-haikei.png',
                  ),
                  color: Palette.green),
            ),
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
                  const CustomInputField(
                    height: 70,
                    color: Colors.white,
                    labelText: 'Email',
                    hintText: 'Ingresa tu email',
                  ),
                  const CustomPasswordInputField(
                    height: 70,
                    color: Colors.white,
                    labelText: 'Contraseña',
                    hintText: 'Ingresa tu contraseña',
                  ),
                  const SizedBox(height: 20),
                  const LittleAccesWidget(),
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

class LittleAccesWidget extends StatelessWidget {
  const LittleAccesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/recovery/Password');
            },
            style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent)),
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Olvidaste tu contraseña?',
                  style: TextStyle(fontFamily: 'Poppins')),
            )),
        CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 25,
                    vertical: 15),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                  color: Palette.purple,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Acceder',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
                )),
            onPressed: () {}),
      ],
    );
  }
}
