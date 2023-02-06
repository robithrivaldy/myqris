import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:myqris/pages/detail_transaction_page.dart';
import 'package:myqris/sheets/tarik_saldo_confirm_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_status_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class WithdrawCard extends StatelessWidget {
  final WithdrawModel data;
  const WithdrawCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorBadge = Colors.black;
    Color textBadge = Colors.black;
    var statusTxt = '';
    // final dateTime = DateTime.parse(data.createdAt!);
    // final format = DateFormat('dd MMMM yyyy HH:mm');
    // var tanggal = format.format(dateTime);
    var tanggal = data.createdAt!;
    if (data.submissionStatus == 'Approved') {
      colorBadge = const Color(0xFFE4F6DE);
      textBadge = greenColor;
      statusTxt = 'Diterima';
    }

    if (data.submissionStatus == 'Requested') {
      colorBadge = const Color(0xFFFFF3DB);
      textBadge = yellowColor;
      statusTxt = 'Diproses';
    }

    if (data.submissionStatus == 'Rejected') {
      colorBadge = const Color(0xFFF5D5D6);
      textBadge = redColor;
      statusTxt = 'Ditolak';
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(14),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return TarikSaldoStatusSheet(data);
            });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: greyColor.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(2, 5) // changes position of shadow
                ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/money.png",
              width: 36,
              height: 36,
            ),
            // const SizedBox(
            //   width: 12,
            // ),

            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Penarikan Saldo",
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    tanggal,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(data.amount),
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: colorBadge,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      statusTxt,
                      style: nunitoTextStyle.copyWith(
                        color: textBadge,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
