import 'dart:ffi';

class AddTransactionModel {
  int? accountid;
  int? categoryid;
  int? amount;
  String? date;
  String? type;
  String? description;
  bool? onbudget;

  AddTransactionModel(
      {required this.accountid,
      required this.amount,
      required this.categoryid,
      required this.date,
      required this.description,
      required this.onbudget,
      required this.type});
}
