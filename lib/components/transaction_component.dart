import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/material.dart';

class TransactionComponent extends StatefulWidget {
  final String name;
  final String type;
  final double value;
  const TransactionComponent(
      {super.key, required this.name, required this.type, required this.value});

  @override
  State<TransactionComponent> createState() => _TransactionComponentState();
}

class _TransactionComponentState extends State<TransactionComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFF1F4F8),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const CircleAvatar(
                backgroundColor: Color(0xFF6D5FED),
                radius: 30,
                child: Icon(
                  Icons.monetization_on,
                )),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  )),
              Text(widget.type,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ))
            ]),
          ],
        ),
        Text(widget.value.toString(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Palette.purple,
            ))
      ]),
    );
  }
}
