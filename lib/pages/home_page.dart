import 'package:finanzas/components/transaction_component.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/models/logged_user.dart';

import 'package:finanzas/providers/auth_provider.dart';
import 'package:finanzas/providers/transactions_provider.dart';
import 'package:finanzas/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
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
  bool _isLoading = true;
  LoggedUser? user;
  late SharedPreferences prefs;

  List<Widget> transactionList = [];
  readFromSharedPrefs() async {
    setState(() {
      name = prefs.getString("firstName") ?? "";
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
    Provider.of<AuthProvider>(context, listen: false)
        .getUserData()
        .then((value) {
      getSharedPreferences();
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });

    getTransactions();

    super.initState();
  }

  void getTransactions() async {
    Provider.of<TransactionsProvider>(context, listen: false)
        .getTransactionsNow()
        .then((value) {
      for (var element in value) {
        transactionList.add(TransactionComponent(
            name: element.name,
            type: (element.entry == true) ? "Ingreso" : "Gasto",
            value: element.amount));
      }
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.bg,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: const Text(
                                        "Sus últimas actualizaciones están a continuación.",
                                        maxLines: 4,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            letterSpacing: -0.6),
                                      ),
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
                                        color:
                                            Color.fromARGB(134, 126, 126, 126),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                      vertical: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF1F4F8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "lib/assets/images/arrows.png"),
                                                            width: 30,
                                                          ),
                                                          SizedBox(height: 25),
                                                          Text("Movimientos",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                        ]),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/myBudgets');
                                                  },
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 30),
                                                CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                      vertical: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF1F4F8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                              "lib/assets/images/asc.png",
                                                            ),
                                                            width: 40,
                                                          ),
                                                          SizedBox(height: 25),
                                                          Text(
                                                              "    Actividad    ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                        ]),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/graphics');
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: ListView.builder(
                                            itemCount: transactionList.length,
                                            itemBuilder: (contex, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: transactionList[index],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ))),
                          ],
                        )
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: CupertinoButton(
                          color: Colors.transparent,
                          onPressed: () {
                            showModalSheet(context);
                          },
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
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
