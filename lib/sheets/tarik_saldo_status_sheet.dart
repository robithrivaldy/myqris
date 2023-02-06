import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/withdraw_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TarikSaldoStatusSheet extends StatefulWidget {
  final WithdrawModel data;
  TarikSaldoStatusSheet(this.data, {Key? key}) : super(key: key);

  @override
  State<TarikSaldoStatusSheet> createState() => _TarikSaldoStatusSheetState();
}

class _TarikSaldoStatusSheetState extends State<TarikSaldoStatusSheet> {
  var title = '';
  var message = '';
  @override
  Widget build(BuildContext context) {
    if (widget.data.submissionStatus == "Requested") {
      title = "⌛️ Saldo Sedang Dikirim";
      message =
          "Saldo Anda sedang diproses untuk dikirim ke akun rekening anda, silakan menunggu 1x24 jam.";
    } else if (widget.data.submissionStatus == "Approved") {
      title = "Saldo Berhasil Dikirim 💰🥳";
      message =
          "Saldo berhasil dikirim🥳, silakan cek saldo pada rekening anda.";
    } else if (widget.data.submissionStatus == "Rejected") {
      title = "Penarikan Saldo Ditolak ⛔️";
      message =
          "Penarikan ditolak karena anda melanggar syarat dan ketentuan kami. Jika anda merasa tidak melanggar anda bisa menghubungi kami di\n\nmyqrisku@gmail.com";
    }
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
            widget.data.submissionStatus == "Rejected"
                ? Row(
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Penarikan ditolak karena anda melanggar",
                                style: nunitoTextStyle.copyWith(
                                  color: const Color(0xff545454),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: " syarat dan ketentuan ",
                                style: nunitoTextStyle.copyWith(
                                  color: blueColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://cooing-moat-59d.notion.site/Terms-Conditions-317aeb029981494c9acb0e7c99c69983');
                                  },
                              ),
                              TextSpan(
                                text:
                                    "Jika anda merasa tidak melanggar anda bisa menghubungi kami di\n\nmyqrisku@gmail.com",
                                style: nunitoTextStyle.copyWith(
                                  color: const Color(0xff545454),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
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
            widget.data.submissionStatus != "Rejected"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Bank',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.bankCode!,
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
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
                              'Nomor Rekening',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.beneficiaryAccountNumber!,
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
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
                              'Nama Pemilik',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.beneficiaryAccountHolder!,
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
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
                              'Total Penarikan',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(widget.data.amount),
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
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
                              'Biaya Withdraw',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(widget.data.fee),
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
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
                              'Bank Pengirim',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.sendBy.toString(),
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
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
