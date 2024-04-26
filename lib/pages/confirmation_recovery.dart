import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/material.dart';

class ConfirmationRecovery extends StatefulWidget {
  const ConfirmationRecovery({super.key});

  @override
  State<ConfirmationRecovery> createState() => _ConfirmationRecoveryState();
}

class _ConfirmationRecoveryState extends State<ConfirmationRecovery> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.bg,
    );
  }
}
