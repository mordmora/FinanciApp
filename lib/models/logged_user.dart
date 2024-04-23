import 'dart:convert';

LoggedUser loggedUserFromJson(String str) =>
    LoggedUser.fromJson(json.decode(str));

String loggedUserToJson(LoggedUser data) => json.encode(data.toJson());

class LoggedUser {
  bool active;
  double defaultBudget;
  String email;
  String firstName;
  String lastName;
  int term;

  LoggedUser({
    required this.active,
    required this.defaultBudget,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.term,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) => LoggedUser(
        active: json["active"],
        defaultBudget: json["default_budget"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        term: json["term"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "default_budget": defaultBudget,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "term": term,
      };
}
