import 'package:finanzas/components/movement_card.dart';
import 'package:finanzas/components/transaction_component.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finanzas/providers/transactions_provider.dart';

class Mybudgets extends StatefulWidget {
  const Mybudgets({super.key});

  @override
  State<Mybudgets> createState() => _MybudgetsState();
}

class _MybudgetsState extends State<Mybudgets> {
  late SharedPreferences prefs;
  String budgetText = "";
  List<Widget> transactionList = [];

  @override
  void initState() {
    getTransactions();

    super.initState();
  }

  void getTransactions() async {
    Provider.of<TransactionsProvider>(context, listen: false)
        .getTransactionsNow()
        .then((value) {
      for (var element in value) {
        transactionList.add(TransactionsComponentDetails(
            name: element.name,
            date: element.date,
            value:
                (element.entry == true) ? element.amount : element.amount * -1,
            description: element.description));
      }
    }).whenComplete(() {
      setState(() {});
    });

    Provider.of<TransactionsProvider>(context, listen: false)
        .getBudget()
        .then((budget) {
      budgetText = budget;
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Mi Presupuesto",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Poppins',
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 189, 189, 189)
                          .withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    )
                  ]),
              height: MediaQuery.of(context).size.height * 0.16,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Presupuesto",
                      ),
                      Text(
                        formatearAMoneda(budgetText),
                        style: TextStyle(
                            fontSize: 40,
                            color:
                                (budgetText.length > 0 && budgetText[1] == "-")
                                    ? Color.fromARGB(255, 255, 101, 101)
                                    : Color.fromARGB(255, 117, 101, 255),
                            fontFamily: 'Poppins',
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.165,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC5EDE7),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2.5%",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              Image(
                                image: AssetImage("lib/assets/images/asc.png"),
                                width: 25,
                              )
                            ]),
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: transactionList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: transactionList[index],
                        );
                      })),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        showModalSheet(context);
                      },
                      backgroundColor: const Color(0xFF39D2C0),
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
