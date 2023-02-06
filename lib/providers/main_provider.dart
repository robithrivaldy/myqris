import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/main_model.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/services/auth_service.dart';
import 'package:myqris/services/main_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/utils/constants.dart';
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

  Future<void> getStart() async {
    await MainService().getMain().then((value) {
      _main = value;
      Get.offAll(HomePage());
    }).catchError((err) {
      MsgHelper.snackErrorTry(() {
        getStart();
      });
    });
  }

  Future<void> getMain() async {
    isLoading = true;
    await MainService().getMain().then((value) {
      isLoading = false;
      _main = value;
    }).catchError((err) {
      MsgHelper.snackErrorTry(() {
        getMain();
      });
    });

    // try {
    //   MainModel main = await MainService().getMain();
    //   _main = main;
    //   return true;
    // } catch (e) {
    //   return false;
    //   // print(e);
    //   // _main = null;
    //   // _isLoading = false;
    // }
  }
}
