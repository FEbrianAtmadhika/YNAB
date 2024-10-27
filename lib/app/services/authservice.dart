import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ynab/app/Shared/baseapi.dart';
import 'package:ynab/app/model/addtransactionmodel.dart';
import 'package:ynab/app/model/authmodel.dart';
import 'package:ynab/app/model/signinmodel.dart';
import 'package:ynab/app/services/securestorageservices.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = Baseapi().url;

  Future<AuthModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/login',
        ),
        body: {'email': data.email, 'password': data.password},
      );
      Map<String, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['message'] == "Authenticated") {
        final auth = AuthModel.fromJson(rawdata);

        return auth;
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

  Future<void> logout() async {
    try {
      String? token = await SecureStorageServices().getToken();
      final url = "$baseUrl/logout";
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      Map<dynamic, dynamic> rawdata = jsonDecode(res.body);
      print(res.body);
      if (rawdata['code'] == 200) {
        await SecureStorageServices().clearLocalStorage();
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

  Future<AuthModel> addTransaction(
      AuthModel user, AddTransactionModel transaction) async {
    try {
      String? token = await SecureStorageServices().getToken();
      final url = Uri.parse("$baseUrl/transactions");

      var request = http.MultipartRequest('POST', url);

      // Menambahkan token ke dalam header
      request.headers['Authorization'] = 'Bearer $token';

      // Menambahkan body parameters ke dalam request
      request.fields['account_id'] = transaction.accountid.toString();
      request.fields['category_id'] = transaction.categoryid.toString();
      request.fields['amount'] = transaction.amount.toString();
      request.fields['transaction_date'] = transaction.date!;
      request.fields['type'] = transaction.type!;
      request.fields['description'] = transaction.description!;
      request.fields['on_budget'] = 'true';

      // Mengirim request dan mendapatkan response
      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      print(res.body);

      Map<dynamic, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 201) {
        Transaction temp = Transaction.fromJson(rawdata['data']['transaction']);
        int index = user.user.accounts.indexWhere((e) {
          return e.id == temp.accountId;
        });
        user.user.accounts[index].transactions.add(temp);
        return user;
      } else {
        return rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }
}
