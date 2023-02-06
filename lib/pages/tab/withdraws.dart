import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/transaction_card.dart';
import 'package:myqris/widgets/withdraw_card.dart';
import 'package:provider/provider.dart';

class Withdraws extends StatefulWidget {
  Withdraws({Key? key}) : super(key: key);

  @override
  State<Withdraws> createState() => _WithdrawsState();
}

class _WithdrawsState extends State<Withdraws> {
  getdata() async {
    await Provider.of<MainProvider>(context, listen: false).getMain();
    await Provider.of<WithdrawProvider>(context, listen: false).getWithdraw();
  }

  @override
  Widget build(BuildContext context) {
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);
    return withdrawProvider.withdraw.isEmpty
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
                  "Belum ada penarikan saldo",
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
                children: withdrawProvider.withdraw
                    .map(
                      (e) => WithdrawCard(e),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
