import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String budget = "";
  String term = "";

  late SharedPreferences prefs;
  readFromSharedPrefs() async {
    setState(() {
      name = prefs.getString("name") ?? "";
      budget = prefs.getString("budget") ?? "";
      term = prefs.getString("terms") ?? "";
    });
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    readFromSharedPrefs();
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: Container(
          color: Palette.purple,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Palette.bg,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 138, 138, 138),
                            size: 45,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Bienvenido, ",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                      )),
                                  Text(name,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: Palette.purple)),
                                ],
                              ),
                              const Text(
                                "Sus últimas actualizaciones están a continuación.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    letterSpacing: -0.6),
                                overflow: TextOverflow.clip,
                              ),
                            ])
                      ])),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(134, 126, 126, 126),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Historial",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      )),
                                  const SizedBox(height: 10),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF1F4F8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "lib/assets/images/arrows.png"),
                                              width: 20,
                                            ),
                                            SizedBox(height: 25),
                                            Text("Movimientos",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13,
                                                    color: Colors.black)),
                                          ]),
                                    ),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Transacciones",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 320,
                                    child: ListView(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xFFF1F4F8),
                                          ),
                                          child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Color(0xFF6D5FED),
                                                        radius: 30,
                                                        child: Icon(
                                                          Icons.monetization_on,
                                                        )),
                                                    SizedBox(width: 20),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Horas extras",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 20,
                                                              )),
                                                          Text("Ingreso",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ))
                                                        ]),
                                                  ],
                                                ),
                                                Text("\$10.000",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Palette.purple,
                                                    ))
                                              ]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    ],
                  )
                ]),
              ),
              Container(
                alignment: Alignment.center,
                child: CupertinoButton(
                  onPressed: () {},
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text(
                        "Agregar movimiento",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.black),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
