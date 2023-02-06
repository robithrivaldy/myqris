import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myqris/models/profile_model.dart';
import 'package:myqris/models/withdraw_model.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/sheets/bank_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_confirm_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/bank_card.dart';
import 'package:provider/provider.dart';

class TarikSaldoNewSheet extends StatefulWidget {
  final ProfileModel data;
  TarikSaldoNewSheet(this.data, {Key? key}) : super(key: key);

  @override
  State<TarikSaldoNewSheet> createState() => _TarikSaldoNewSheetState();
}

class _TarikSaldoNewSheetState extends State<TarikSaldoNewSheet> {
  var showButton = false;
  var showSaldo = true;
  bool isAlert = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<WithdrawProvider>(context, listen: false).getBank();

    Provider.of<WithdrawProvider>(context, listen: false).bankCode =
        widget.data.bankCode!;
    Provider.of<WithdrawProvider>(context, listen: false)
        .accountHolderController
        .text = widget.data.beneficiaryAccountHolder!;
    Provider.of<WithdrawProvider>(context, listen: false)
        .accountNumberController
        .text = widget.data.beneficiaryAccountNumber!;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);

    if (authProvider.profile.saldo! < 100000) {
      withdrawProvider.validator = false;
    } else {
      withdrawProvider.validator = true;
    }

    if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
      showButton = false;
    } else {
      showButton = true;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '💰Tarik Saldo',
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
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xff1C1D23),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saldo Anda',
                      style: nunitoTextStyle.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(authProvider.profile.saldo!),
                  style: nunitoTextStyle.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          withdrawProvider.validator == false
              ? Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Minimal Withdraw Rp 100.000',
                      style: nunitoTextStyle.copyWith(
                        color: const Color(0xffFF314A),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    autocorrect: true,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    onTap: () => showModalBottomSheet<void>(
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
                          return BankSheet();
                        });
                      },
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      isDense: true,
                      hintText: withdrawProvider.bankCode,
                      hintStyle: nunitoTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      fillColor: whiteColor,
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 30,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    controller: withdrawProvider.accountNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputAction: TextInputAction.done,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      isDense: true,
                      hintText: ' No Rekening (Pastikan Benar)',
                      hintStyle: nunitoTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      fillColor: whiteColor,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    controller: withdrawProvider.accountHolderController,
                    textInputAction: TextInputAction.done,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      isDense: true,
                      hintText: ' Nama Rekening (Pastikan Benar)',
                      hintStyle: nunitoTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      fillColor: whiteColor,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isAlert == true
              ? Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Mohon lengkapi bank tujuan tarik saldo!',
                      style: nunitoTextStyle.copyWith(
                        color: const Color(0xffFF314A),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 16,
          ),
          showButton == true
              ? Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  width: double.infinity,
                  height: 56,
                  decoration: const BoxDecoration(),
                  // ignore: deprecated_member_use
                  child: withdrawProvider.validator == true
                      ? RaisedButton(
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          onPressed: () {
                            if (withdrawProvider.bankCode == 'Pilih Bank' ||
                                withdrawProvider.accountHolderController.text ==
                                    '' ||
                                withdrawProvider.accountNumberController.text ==
                                    '') {
                              setState(() {
                                isAlert = true;
                              });
                            } else {
                              Navigator.pop(context);
                              showModalBottomSheet<void>(
                                // isScrollControlled: true,
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.5),

                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14.0),
                                      topRight: Radius.circular(14.0)),
                                ),
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setNewState) {
                                    return TarikSaldoConfirmSheet();
                                  });
                                },
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          color: blackColor,
                          splashColor: greyColor,
                          child: Text(
                            'Tarik Saldo',
                            style: nunitoTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: whiteColor,
                            ),
                          ),
                        )
                      : RaisedButton(
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          onPressed: () {
                            // Navigator.pop(context);
                            // showModalBottomSheet<void>(
                            //   // isScrollControlled: true,
                            //   context: context,
                            //   barrierColor: Colors.black.withOpacity(0.5),

                            //   shape: const RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(14.0),
                            //         topRight: Radius.circular(14.0)),
                            //   ),
                            //   builder: (BuildContext context) {
                            //     return StatefulBuilder(
                            //         builder: (context, setNewState) {
                            //       return tarikSaldoYakin(context);
                            //     });
                            //   },
                            // );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          color: Color(0xffD1D5DB),
                          splashColor: greyColor,
                          child: Text(
                            'Tarik Saldo',
                            style: nunitoTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: whiteColor,
                            ),
                          ),
                        ))
              : Container(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
