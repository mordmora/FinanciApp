import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/material.dart';

class Graphics extends StatefulWidget {
  const Graphics({super.key});

  @override
  State<Graphics> createState() => _GraphicsState();
}

class _GraphicsState extends State<Graphics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.purple,
    );
  }
}
