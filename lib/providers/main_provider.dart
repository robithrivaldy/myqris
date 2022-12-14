import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/main_model.dart';
import 'package:myqris/services/auth_service.dart';
import 'package:myqris/services/main_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;
  MainModel? _main;
  MainModel get main => _main!;

  set main(MainModel main) {
    _main = main;
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> getMain() async {
    _isLoading = true;
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
      MainModel main = await MainService().getMain();

      _main = main;
      isLoading = false;

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
