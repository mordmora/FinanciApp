import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finanzas/components/movement_card.dart';

class TransactionComponent extends StatefulWidget {
  final String name;
  final String type;
  final String id;
  final double value;
  final Widget button;
  const TransactionComponent(
      {super.key,
      required this.name,
      required this.type,
      required this.value,
      required this.id,
      required this.button});

  @override
  State<TransactionComponent> createState() => _TransactionComponentState();
}

class TransactionsComponentDetails extends StatefulWidget {
  final String name;
  final String date;
  final double value;
  final String description;

  const TransactionsComponentDetails(
      {super.key,
      required this.name,
      required this.date,
      required this.value,
      required this.description});

  @override
  State<TransactionsComponentDetails> createState() =>
      _TransactionComponentDetailState();
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
              Text(
                  (widget.name.length > 9)
                      ? widget.name.substring(0, 9)
                      : widget.name,
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
        Row(
          children: [
            Text(widget.value.toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Palette.purple,
                )),
            widget.button
          ],
        ),
      ]),
    );
  }
}

class _TransactionComponentDetailState
    extends State<TransactionsComponentDetails> {
  @override
  Widget build(BuildContext context) {
    String description = widget.description;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Descripción:"),
                  content: Text(description),
                ));
      },
      child: MovementCard(
        color: Palette.purple,
        title: widget.name,
        value: widget.value.toString(),
        time: widget.date.toString(),
      ),
    );
  }
  /* CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                    title: Text("Descripcion :)")));
                          },
                          child: MovementCard(
                            color: index < 1
                                ? Palette.purple
                                : const Color.fromARGB(255, 155, 146, 238),
                            title: "Ingresos",
                            value: "-\$500.000",
                            time: "2 meses",
                          ),
                        ); */
}
