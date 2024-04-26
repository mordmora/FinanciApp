import 'package:finanzas/components/labeled_input_field.dart';
import 'package:finanzas/components/outlined_text_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/models/budgets.dart';
import 'package:finanzas/providers/budgets_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMovement extends StatefulWidget {
  final String type;

  const AddMovement({super.key, required this.type});

  @override
  State<AddMovement> createState() => _AddMovementState();
}

class _AddMovementState extends State<AddMovement> {
  String value = "";
  String _motive = "";
  String _reason = "";
  bool budgetAlert = false;
  late NavigatorObserver observer;
  String type = "ingreso";
  List<bool> active = [true, false];

  final _reasonController = TextEditingController();
  final valueController = TextEditingController();
  final _motiveController = TextEditingController();

  @override
  void initState() {
    _reasonController.addListener(() {
      _reason = _reasonController.text;
    });
    valueController.addListener(() {
      value = valueController.text.isEmpty ? "0" : valueController.text;
    });
    _motiveController.addListener(() {
      _motive = _motiveController.text;
    });
    super.initState();
  }

  bool validMovement() {
    if (value.isEmpty || value == "0") {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    valueController.dispose();
    _motiveController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.purple,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 78, 78, 78),
                      blurRadius: 20,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: SafeArea(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Registrar movimiento',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close, size: 40))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: OutlinedTextField(
                        borderColor: budgetAlert ? Colors.red : Colors.grey,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: valueController,
                        onChanged: (input) {
                          setState(() {
                            budgetAlert = false;
                          });
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: LabeledTextField(
                        controller: _motiveController,
                        label: "Motivo",
                        maxLines: 1,
                        hintText: 'Ingresa el motivo del egreso',
                        isPassword: false,
                        borderColor: Colors.grey,
                        color: Colors.transparent,
                        onChanged: (p0) {
                          setState(() {
                            _motive = _motiveController.text;
                          });
                        },
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: LabeledTextField(
                      controller: _reasonController,
                      label: "Descripción",
                      minLines: 1,
                      maxLines: 3,
                      isPassword: false,
                      borderColor: Colors.grey,
                      color: Colors.transparent,
                      onChanged: (p0) {
                        setState(() {
                          _reason = _reasonController.text;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Row(
                      children: [
                        Checkbox(
                            value: active[0],
                            onChanged: (value) {
                              setState(() {
                                active[1] = false;
                                active[0] = true;
                                type = "ingreso";
                              });
                            }),
                        const Text("Ingreso", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: active[1],
                            onChanged: (value) {
                              setState(() {
                                active[0] = false;
                                active[1] = true;
                                type = "egreso";
                              });
                            }),
                        const Text("Gasto", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
                ]),
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  color: Palette.purple,
                  child: const Text(
                    'Confirmar',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 24),
                  ),
                  onPressed: () {
                    if (validMovement()) {
                      String typeMovement = "";
                      if (type == "ingreso") {
                        typeMovement = "entry";
                      } else if (type == "egreso") {
                        typeMovement = "payment";
                      }
                      Budget budget = Budget(
                          amount: double.parse(value),
                          type: typeMovement,
                          name: _motive,
                          description: _reason);
                      Provider.of<BudgetProvider>(context, listen: false)
                          .addBudget(budget)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(value[1]["message"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 15)),
                          backgroundColor:
                              (value[0] == 200) ? Palette.green : Palette.red,
                          behavior: SnackBarBehavior.fixed,
                          duration: const Duration(seconds: 5),
                          elevation: 4,
                        ));
                      }).whenComplete(() => Navigator.pop(context));

                      setState(() {});
                    } else {
                      budgetAlert = true;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
