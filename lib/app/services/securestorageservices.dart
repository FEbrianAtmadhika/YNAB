import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ynab/app/model/authmodel.dart';
import 'package:ynab/app/model/signinmodel.dart';

class SecureStorageServices {
  Future<void> storeCredentialToLocal(
      String token, String email, String password) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'token', value: token);
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if (value != null) {
      token = value;
    }

    return token;
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['token'] != null) {
        final SignInFormModel data = SignInFormModel(
          email: values['email'],
          password: values['password'],
        );

        return data;
      } else {
        throw 'unauthenticated';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
