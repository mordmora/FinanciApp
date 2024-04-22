import 'dart:convert';

Budget budgetFromJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
  double amount;
  String type;
  String name;
  String description;

  Budget({
    required this.amount,
    required this.type,
    required this.name,
    required this.description,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        amount: json["amount"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "type": type,
        "name": name,
        "description": description,
      };
}
