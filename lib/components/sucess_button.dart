import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';

class SucessButton extends StatefulWidget {
  const SucessButton({super.key, required this.route});
  final String route;

  @override
  State<SucessButton> createState() => _SucessButtonState();
}

class _SucessButtonState extends State<SucessButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        color: Palette.purple,
        child: const Text(
          'Confirmar',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: BorderSide.strokeAlignInside),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, widget.route, (_) => false,
              arguments: widget.route);
        });
  }
}
