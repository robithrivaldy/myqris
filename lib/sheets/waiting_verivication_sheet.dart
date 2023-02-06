import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/withdraw_card.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingVerivicationSheet extends StatefulWidget {
  const WaitingVerivicationSheet({Key? key}) : super(key: key);

  @override
  State<WaitingVerivicationSheet> createState() =>
      _WaitingVerivicationSheetState();
}

class _WaitingVerivicationSheetState extends State<WaitingVerivicationSheet> {
  var title = '⏳ Mohon menunggu 2x24 jam';
  var message =
      'Proses verifikasi sebagai syarat untuk tarik saldo memerlukan waktu 2x24 jam';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(left: 0),
                  splashColor: greyColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: blackColor,
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff545454),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: const BoxDecoration(),
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: blackColor,
                splashColor: greyColor,
                child: Text(
                  'Okey',
                  style: nunitoTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
