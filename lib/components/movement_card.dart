import 'package:flutter/material.dart';

class MovementCard extends StatefulWidget {
  final String title;
  final String value;
  final String time;
  final Color color;
  const MovementCard(
      {super.key,
      required this.title,
      required this.value,
      required this.color,
      required this.time});

  @override
  State<MovementCard> createState() => _MovementCardState();
}

class _MovementCardState extends State<MovementCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      height: height * 0.15,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      letterSpacing: -0.4)),
              Row(
                children: [
                  Text(
                    "Hace ${widget.time}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        letterSpacing: -0.4),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        letterSpacing: -0.4),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
