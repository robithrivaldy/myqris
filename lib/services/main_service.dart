import 'dart:convert';
import 'dart:io';

import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/main_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainService {
  SharedPreferences? _sharedPrefs;

  Future<MainModel> getMain() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/home';
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
      MainModel main = MainModel.fromJson(data);

      return main;
    } else {
      throw Exception('Gagal mengambil data ');
    }
  }
}
