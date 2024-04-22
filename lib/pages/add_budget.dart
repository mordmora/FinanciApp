import 'package:finanzas/components/labeled_input_field.dart';
import 'package:finanzas/components/outlined_text_field.dart';
import 'package:finanzas/configurations/color_palette.dart';
import 'package:finanzas/models/budgets.dart';
import 'package:finanzas/providers/auth_provider.dart';
import 'package:finanzas/providers/budgets_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({super.key});

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  String value = "";
  String _motive = "";
  String _reason = "";

  final _reasonController = TextEditingController();
  final valueController = TextEditingController();
  final _motiveController = TextEditingController();

  @override
  void initState() {
    _reasonController.addListener(() {
      _reason = _reasonController.text;
    });
    valueController.addListener(() {
      value = valueController.text;
    });
    _motiveController.addListener(() {
      _motive = _motiveController.text;
    });
    super.initState();
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final budgetProvider = Provider.of<BudgetProvider>(context, listen: false);

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
                        const Text('Registrar Egreso',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: valueController,
                        onChanged: (value) {
                          setState(() {
                            value = valueController.text;
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
                    Budget budget = Budget(
                        amount: double.parse(value),
                        type: "egreso",
                        name: _motive,
                        description: _reason);
                    String token = authProvider.token;
                    BudgetProvider().addBudget(budget, token);
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
