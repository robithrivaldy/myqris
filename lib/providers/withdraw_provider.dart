import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/models/bank_model.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:myqris/services/withdraw_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;

  final accountNumberController = TextEditingController();
  final accountHolderController = TextEditingController();

  String? _bankCode = '';
  String? _beneficiaryAccountNumber;
  String? _beneficiaryAccountHolder;

  String get bankCode => _bankCode!;
  String get beneficiaryAccountNumber => _beneficiaryAccountNumber!;
  String get beneficiaryAccountHolder => _beneficiaryAccountHolder!;

  bool? _validator = true;
  bool get validator => _validator!;

  bool? _showBank = true;
  bool get showBank => _showBank!;

  set showBank(bool data) {
    _showBank = data;
    notifyListeners();
  }

  set validator(bool data) {
    _validator = data;
    notifyListeners();
  }

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
      List<BankModel> data = await WithdrawService().getBank();

      _bank = data;
    } catch (e) {
      print(e);
    }
  }

  List<WithdrawModel> _withdraw = [];
  List<WithdrawModel> get withdraw => _withdraw;

  set withdraw(List<WithdrawModel> data) {
    _withdraw = data;
    notifyListeners();
  }

  Future<void> getWithdraw() async {
    // try {
    //   // EasyLoading.show(dismissOnTap: false);

    //   List<WithdrawModel> data = await WithdrawService().getWithdraw();
    //   // EasyLoading.dismiss();
    //   _withdraw = data;
    //   return true;
    // } catch (e) {
    //   // EasyLoading.dismiss();
    //   print(e);
    //   return false;
    // }

    await WithdrawService().getWithdraw().then((value) {
      List<WithdrawModel> data = value;
      _withdraw = data;
    }).catchError((err) {
      MsgHelper.snackErrorTry(() {
        getWithdraw();
      });
    });
  }

  WithdrawModel? _withdrawDetail;
  WithdrawModel get withdrawDetail => _withdrawDetail!;

  set withdrawDetail(WithdrawModel data) {
    _withdrawDetail = data;
    notifyListeners();
  }

  Future<void> getDetailWithdraw(id) async {
    try {
      EasyLoading.show(dismissOnTap: false);

      WithdrawModel data = await WithdrawService().getDetailWithdraw(id);
      EasyLoading.dismiss();
      _withdrawDetail = data;
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  // Future<void> requestWithdraw() async {
  //   EasyLoading.show(dismissOnTap: false);

  //   await WithdrawService()
  //       .requestWithdraw(_bankCode, accountNumberController.text,
  //           accountHolderController.text)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //   }).catchError((er) {
  //     EasyLoading.dismiss();
  //     MsgHelper.snackErrorTry(() {
  //       requestWithdraw();
  //     });
  //   });
  // }
}
