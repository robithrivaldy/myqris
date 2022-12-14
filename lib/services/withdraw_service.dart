import 'dart:convert';

import 'package:myqris/models/bank_model.dart';
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

  Future<bool> requestWithdraw(bankCode, number, holder) async {
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
      return true;
    } else {
      throw Exception('Gagal');
    }
  }
}
