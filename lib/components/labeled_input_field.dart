import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LabeledTextField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? formatter;
  final Color borderColor;
  const LabeledTextField(
      {super.key,
      required this.label,
      required this.isPassword,
      required this.controller,
      required this.borderColor,
      this.onChanged,
      this.formatter});

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool isObscured = false;

  @override
  void initState() {
    isObscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color borderCol = widget.borderColor;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: borderCol,
                width: 1.0,
              ),
              top: BorderSide(
                color: borderCol,
                width: 1.0,
              ),
              left: BorderSide(
                color: borderCol,
                width: 1.0,
              ),
              right: BorderSide(
                color: borderCol,
                width: 1.0,
              )),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
            inputFormatters: widget.formatter,
            onChanged: widget.onChanged,
            controller: widget.controller,
            obscureText: isObscured,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: isObscured
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      )
                    : null,
                labelText: widget.label,
                labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 77, 77, 77),
                    fontSize: 15),
                border: InputBorder.none)),
      ),
    );
  }

  Widget passwordField() {
    return Container(
        decoration: const BoxDecoration(
      color: Colors.white,
    ));
  }
}
