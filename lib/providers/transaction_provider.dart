import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/models/limit_transaction_model.dart';
import 'package:myqris/models/main_model.dart';
import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/pages/detail_transaction_page.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/services/main_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/services/transaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;

  final nominalQrController = TextEditingController();

  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  TransactionsModel? _transaction;
  TransactionsModel get transaction => _transaction!;

  set transaction(TransactionsModel data) {
    _transaction = data;
    notifyListeners();
  }

  TransactionsModel? _transactionDetail;
  TransactionsModel get transactionDetail => _transactionDetail!;

  set transactionDetail(TransactionsModel data) {
    _transactionDetail = data;
    notifyListeners();
  }

  Future<void> createQr() async {
    EasyLoading.show(dismissOnTap: false);

    await TransactionService()
        .createQr(nominalQrController.text.replaceAll('.', ''))
        .then((value) {
      _transaction = value;
      EasyLoading.dismiss();
      Get.offAll(
        DetailTransactionPage(value),
      );
    }).catchError((err) {
      EasyLoading.dismiss();
      MsgHelper.snackErrorTry(() {
        createQr();
      });
    });
  }

  Future<void> getDetailTransaction(id) async {
    try {
      EasyLoading.show(dismissOnTap: false);

      TransactionsModel data =
          await TransactionService().getDetailTransaction(id);
      EasyLoading.dismiss();
      _transactionDetail = data;

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> cancelTransaction(id) async {
    await TransactionService().cancelTransaction(id).then((value) async {
      EasyLoading.dismiss();

      Get.offAll(const HomePage());
    }).catchError((err) {
      MsgHelper.snackErrorTry(() {
        cancelTransaction(id);
      });
    });
  }
}
