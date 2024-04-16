import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final double height;
  final Color color;
  final String? labelText;
  final String? hintText;
  const CustomInputField(
      {super.key,
      required this.height,
      required this.color,
      this.labelText,
      this.hintText});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 70,
        child: TextFormField(
            decoration: InputDecoration(
          label: Text(
            widget.labelText ?? '',
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
          hintText: widget.hintText ?? '',
          hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: widget.color, width: 0),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(color: Colors.white, width: 0)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
                color: Colors.white, width: 0, style: BorderStyle.none),
          ),
        )),
      ),
    );
  }
}
