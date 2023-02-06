import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/services/withdraw_service.dart';
import 'package:myqris/sheets/tarik_saldo_diterima_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:provider/provider.dart';

class TarikSaldoConfirmSheet extends StatefulWidget {
  TarikSaldoConfirmSheet({Key? key}) : super(key: key);

  @override
  State<TarikSaldoConfirmSheet> createState() => _TarikSaldoConfirmSheetState();
}

class _TarikSaldoConfirmSheetState extends State<TarikSaldoConfirmSheet> {
  @override
  Widget build(BuildContext context) {
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);
    confirmHandle() async {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
      await WithdrawService()
          .requestWithdraw(
              withdrawProvider.bankCode,
              withdrawProvider.accountNumberController.text,
              withdrawProvider.accountHolderController.text)
          .then((value) {
        EasyLoading.dismiss();

        Navigator.pop(context);
        setState(() {});
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          barrierColor: Colors.black.withOpacity(0.5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0)),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setNewState) {
              return TarikSaldoDiterimaSheet();
            });
          },
        );
      }).catchError((err) {
        EasyLoading.dismiss();
        // MsgHelper.snackErrorTry(() {
        //   confirmHandle();
        // });
        MsgHelper.msgPeringatan("Penarikan saldo sedang diproses");
      });
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
                  'Apa anda yakin?',
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
                    'Saldo Anda akan diproses untuk dikirim ke akun rekening dibawah ini',
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
                    withdrawProvider.bankCode,
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
                    withdrawProvider.accountNumberController.text,
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
                    withdrawProvider.accountHolderController.text,
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
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: const Color(0xffE4E4E4), width: 1),
                    ),

                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      color: whiteColor,
                      splashColor: greyColor,
                      child: Text(
                        'Batalkan',
                        style: nunitoTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      onPressed: () async {
                        // Navigator.pop(context);
                        confirmHandle();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      color: blackColor,
                      splashColor: greyColor,
                      child: Text(
                        'Ya yakin',
                        style: nunitoTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
