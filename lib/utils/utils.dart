import 'package:finanzas/configurations/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map<String, String> sliceFullName(String name) {
  var fullName = name.split(' ');
  var firstName = fullName.isEmpty ? "" : fullName[0];
  var lastName = fullName.length > 1 ? fullName[1] : "";
  return {'firstName': firstName, 'lastName': lastName};
}

bool validName(String name) {
  if (name.trim().isEmpty) {
    return false;
  } else {
    var actualWords = name.split(' ').where((word) => word.trim().isNotEmpty);
    if (actualWords.length > 2) {
      return false;
    }
  }
  return true;
}

void showModalSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Palette.purple,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text(
                        "Ingreso",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    onPressed: () {
                      String typeMovement;
                      typeMovement = "ingreso";
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/addMovement',
                          arguments: typeMovement);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Palette.purple,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text(
                        "Egreso",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    onPressed: () {
                      String typeMovement;
                      typeMovement = "egreso";
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/addMovement',
                          arguments: typeMovement);
                    }),
              ),
              SizedBox(height: 10)
            ]);
      });
}

String formatearAMoneda(String numero) {
  print(numero);
  // Convertir el número a String y dividirlo en partes enteras y decimales
  List<String> partes = numero.split('.');

  List<String> parteDos = [];

  if (numero.contains("-")) {
    parteDos = partes[0].split('-');
  } else {
    parteDos = partes[0].split('\$');
  }
  String parteEntera = parteDos.length > 1 ? parteDos[1] : "0";
  String parteDecimal = partes.length > 1 ? partes[1] : "0";

  print(parteDecimal);
  print(parteEntera);
  // Formatear la parte entera con comas cada tres dígitos
  String parteEnteraFormateada = '';
  for (int i = 0; i < parteEntera.length; i++) {
    parteEnteraFormateada += parteEntera[i];
    if ((parteEntera.length - i - 1) % 6 == 0 && i != parteEntera.length - 1) {
      parteEnteraFormateada += "'";
    }
    if ((parteEntera.length - i - 1) % 3 == 0 && i != parteEntera.length - 1) {
      parteEnteraFormateada += ",";
    }
  }

  // Formatear la parte decimal con un punto y una coma
  String parteDecimalFormateada = parteDecimal.padRight(
      1, '0'); // Asegurarse de tener al menos un dígito decimal
  String numeroFormateado = '$parteEnteraFormateada.$parteDecimalFormateada';

  return "\$$numeroFormateado";
}
