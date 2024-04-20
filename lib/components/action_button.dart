import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final void Function() onPressed;
  const ActionButton({super.key, required this.onPressed});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
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
            onPressed: widget.onPressed,
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
                ))),
      ],
    );
  }
}
