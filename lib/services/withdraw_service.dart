import 'dart:convert';

import 'package:myqris/models/bank_model.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myqris/models/profile_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WithdrawService {
  SharedPreferences? _sharedPrefs;

  Future<List<BankModel>> getBank() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/banks';

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
      List data = jsonDecode(response.body)['data'];
      List<BankModel> model = [];

      for (var item in data) {
        model.add(BankModel.fromJson(item));
      }

      return model;
    } else {
      throw Exception('Gagal');
    }
  }

  Future<List<WithdrawModel>> getWithdraw() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/withdraw';

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
      List data = jsonDecode(response.body)['data'];
      List<WithdrawModel> model = [];

      for (var item in data) {
        model.add(WithdrawModel.fromJson(item));
      }

      return model;
    } else {
      throw Exception("gagal");
    }

    // final List rawData = jsonDecode(jsonDecode(response.body)['data']);
    // return rawData.map((f) => WithdrawModel.fromJson(f)).toList();
  }

  Future<WithdrawModel> getDetailWithdraw(id) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/withdraw/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      WithdrawModel main = WithdrawModel.fromJson(data);

      return main;
    } else {
      throw Exception('Gagal mengambil data ');
    }
  }

  Future<void> requestWithdraw(bankCode, number, holder) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/withdraw';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var body = jsonEncode({
      'bank_code': bankCode,
      'beneficiary_account_number': number,
      'beneficiary_account_holder': holder,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    if (response.statusCode == 201) {
    } else {
      throw Exception("Gagal Verivikasi");
    }
  }
}
