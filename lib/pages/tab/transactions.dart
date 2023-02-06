import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/transaction_card.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  getdata() async {
    await Provider.of<MainProvider>(context, listen: false).getMain();
    await Provider.of<WithdrawProvider>(context, listen: false).getWithdraw();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    return mainProvider.main.transactions!.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/empty.png",
                  width: 126,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Belum ada transaksi",
                  style: nunitoTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff94959B),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 42,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              child: Column(
                children: mainProvider.main.transactions!
                    .map(
                      (e) => TransactionCard(e),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
