import 'package:flutter/foundation.dart';

class SignInFormModel extends ChangeNotifier {
  String? email;
  String? password;

  SignInFormModel({required this.email, required this.password});
}
