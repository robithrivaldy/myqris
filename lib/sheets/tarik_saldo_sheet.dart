import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/sheets/bank_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_confirm_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_new_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/bank_card.dart';
import 'package:provider/provider.dart';

class TarikSaldoSheet extends StatefulWidget {
  TarikSaldoSheet({Key? key}) : super(key: key);

  @override
  State<TarikSaldoSheet> createState() => _TarikSaldoSheetState();
}

class _TarikSaldoSheetState extends State<TarikSaldoSheet> {
  var showButton = false;
  var showSaldo = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<WithdrawProvider>(context, listen: false).getBank();
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
    if (authProvider.profile.bankCode == "") {
      withdrawProvider.showBank = false;
    } else {
      withdrawProvider.bankCode = authProvider.profile.bankCode!;
      withdrawProvider.accountHolderController.text =
          authProvider.profile.beneficiaryAccountHolder!;
      withdrawProvider.accountNumberController.text =
          authProvider.profile.beneficiaryAccountNumber!;

      withdrawProvider.showBank = true;
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
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: greyColor.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset:
                              const Offset(1, 3) // changes position of shadow
                          ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authProvider.profile.bankCode!,
                            style: nunitoTextStyle.copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            authProvider.profile.beneficiaryAccountHolder!,
                            style: nunitoTextStyle.copyWith(
                              color: blackColor.withOpacity(0.4),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            authProvider.profile.beneficiaryAccountNumber!,
                            style: nunitoTextStyle.copyWith(
                              color: blackColor.withOpacity(0.4),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setNewState) {
                                  return TarikSaldoNewSheet(
                                      authProvider.profile);
                                });
                              });
                        },
                        splashColor: greyColor,
                        child: Text(
                          "Edit",
                          style: nunitoTextStyle.copyWith(
                            color: Color(0xff2972FF),
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 38),
                //   width: double.infinity,
                //   height: 46,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(14),
                //     border: Border.all(
                //         color: const Color(0xff94959B), width: 1),
                //   ),
                //   // ignore: deprecated_member_use
                //   child: RaisedButton(
                //     elevation: 0,
                //     hoverElevation: 0,
                //     focusElevation: 0,
                //     highlightElevation: 0,
                //     onPressed: () {
                //       handleShowBank();
                //       setState(() {
                //         showBank = false;
                //       });
                //     },
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(14),
                //     ),
                //     color: whiteColor,
                //     splashColor: greyColor,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const Icon(Icons.add),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'Tambah Bank',
                //           style: nunitoTextStyle.copyWith(
                //             fontSize: 16,
                //             fontWeight: FontWeight.w600,
                //             color: greyColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
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
                            //       return TarikSaldoConfirmSheet();
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
