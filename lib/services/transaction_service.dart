import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myqris/models/main_model.dart';
import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  SharedPreferences? _sharedPrefs;
  Future<TransactionsModel> createQr(nominal) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/request-qr';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var body = jsonEncode({'price': nominal});

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    // if (response.statusCode == 201) {
    //   var data = jsonDecode(response.body)['data'];

    //   TransactionsModel main = TransactionsModel.fromJson(data);
    //   return main;
    // } else {
    //   throw Exception('Gagal');
    // }
    return TransactionsModel.fromJson(jsonDecode(response.body)['data']);
  }

  Future<TransactionsModel> getDetailTransaction(id) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/transactions/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      TransactionsModel main = TransactionsModel.fromJson(data);
      return main;
    } else {
      throw Exception('Gagal');
    }
  }

  Future<bool> cancelTransaction(id) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/cancel-qr/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var response = await http.put(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal');
    }
  }
}
