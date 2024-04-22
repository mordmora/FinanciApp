import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextField extends StatefulWidget {
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  const OutlinedTextField(
      {super.key,
      this.onChanged,
      required this.controller,
      this.inputFormatters});

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'Poppins'),
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            prefixIcon: const Icon(
              Icons.attach_money_outlined,
              color: Colors.black,
              size: 40,
            ),
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                    width: 40))));
  }
}
