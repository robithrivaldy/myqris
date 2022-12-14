import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/pages/detail_transaction_page.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final TransactionsModel data;
  const HistoryCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorBadge = Colors.black;
    Color textBadge = Colors.black;
    var statusTxt = '';
    final dateTime = DateTime.parse(data.createdAt!);
    final format = DateFormat('dd MMMM yyyy HH:mm');
    var tanggal = format.format(dateTime);

    if (data.status == 'Succeed') {
      colorBadge = const Color(0xFFE4F6DE);
      textBadge = greenColor;
      statusTxt = 'Diterima';
    }

    if (data.status == 'WaitingPayment') {
      colorBadge = const Color(0xFFFFF3DB);
      textBadge = yellowColor;
      statusTxt = 'Belum Dibayar';
    }

    if (data.status == 'Cancelled') {
      colorBadge = const Color(0xFFF5D5D6);
      textBadge = redColor;
      statusTxt = 'Dibatalkan';
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransactionPage(data),
          ),
        );
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
                color: greyColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(1, 3) // changes position of shadow
                ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.network(
              data.paidByLogo!,
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
                    data.paidBy!,
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
