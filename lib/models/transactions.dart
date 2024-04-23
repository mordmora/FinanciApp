import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  double amount;
  String name;
  String description;
  String date;
  bool entry;
  String id;

  Transaction({
    required this.amount,
    required this.name,
    required this.description,
    required this.date,
    required this.entry,
    required this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        name: json["name"],
        description: json["description"],
        date: json["date"],
        entry: json["entry"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "name": name,
        "description": description,
        "date": date,
        "entry": entry,
        "id": id,
      };
}
