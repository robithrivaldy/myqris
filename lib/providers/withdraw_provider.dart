import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/models/bank_model.dart';
import 'package:myqris/services/withdraw_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;

  final accountNumberController = TextEditingController();
  final accountHolderController = TextEditingController();

  String? _bankCode = 'Pilih Bank';
  String? _beneficiaryAccountNumber;
  String? _beneficiaryAccountHolder;

  String get bankCode => _bankCode!;
  String get beneficiaryAccountNumber => _beneficiaryAccountNumber!;
  String get beneficiaryAccountHolder => _beneficiaryAccountHolder!;

  set bankCode(String data) {
    _bankCode = data;
    notifyListeners();
  }

  set beneficiaryAccountNumber(String data) {
    _beneficiaryAccountNumber = data;
    notifyListeners();
  }

  set beneficiaryAccountHolder(String data) {
    _beneficiaryAccountHolder = data;
    notifyListeners();
  }

  List<BankModel> _bank = [];
  List<BankModel> get bank => _bank;

  set bank(List<BankModel> data) {
    _bank = data;
    notifyListeners();
  }

  Future<void> getBank() async {
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');

      List<BankModel> data = await WithdrawService().getBank();
      EasyLoading.dismiss();
      _bank = data;
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> requestWithdraw() async {
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');

      await WithdrawService().requestWithdraw(_bankCode,
          accountNumberController.text, accountHolderController.text);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
