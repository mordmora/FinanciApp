import 'package:flutter/material.dart';

class CustomPasswordInputField extends StatefulWidget {
  final double height;
  final Color color;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  const CustomPasswordInputField(
      {super.key,
      required this.controller,
      required this.height,
      required this.color,
      this.labelText,
      this.hintText});

  @override
  State<CustomPasswordInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomPasswordInputField> {
  bool? _isObscured;
  final passwordController = TextEditingController();

  @override
  void initState() {
    _isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 70,
        child: TextFormField(
            controller: widget.controller,
            obscureText: _isObscured!,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured! ? Icons.visibility : Icons.visibility_off,
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured!;
                    });
                  }),
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
