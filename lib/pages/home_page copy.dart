// import 'package:myqris/api/google_api.dart';
// import 'package:myqris/pages/profile_page.dart';
// import 'package:myqris/providers/auth_provider.dart';
// import 'package:myqris/providers/main_provider.dart';
// import 'package:myqris/utils/constants.dart';
// import 'package:myqris/widgets/bank_card.dart';
// import 'package:myqris/widgets/history_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// // import 'package:keyboard_visibility/keyboard_visibility.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   SharedPreferences? _sharedPrefs;
//   var showButton = true;
//   var showBank = true;
//   var showSaldo = true;

//   @override
//   void initState() {
//     getdata();
//     super.initState();
//   }

//   getdata() async {
//     // await Provider.of<MainProvider>(context, listen: false).getMain();
//   }

//   void handleShowBank() {
//     setState(() {
//       showBank = false;
//     });
//   }

//   Widget buatQR(context) {
//     if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
//       showButton = false;
//     } else {
//       showButton = true;
//     }
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//           top: 24,
//           left: 16,
//           right: 16,
//           bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Buat QR',
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               IconButton(
//                 padding: const EdgeInsets.only(left: 0),
//                 splashColor: greyColor,
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.close),
//                 color: blackColor,
//                 iconSize: 30,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: TextField(
//               autocorrect: true,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               textInputAction: TextInputAction.done,
//               style: nunitoTextStyle.copyWith(
//                 color: blackColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//               decoration: InputDecoration(
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                 isDense: true,
//                 hintText: ' Masukkan Harga',
//                 hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
//                 fillColor: whiteColor,
//                 enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   borderSide: BorderSide(color: Color(0xffEAEAEA), width: 1.5),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   borderSide: BorderSide(color: primaryColor, width: 1.5),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           showButton == true
//               ? Container(
//                   margin: const EdgeInsets.only(bottom: 24),
//                   width: double.infinity,
//                   height: 56,
//                   decoration: const BoxDecoration(),
//                   // ignore: deprecated_member_use
//                   child: RaisedButton(
//                     elevation: 0,
//                     hoverElevation: 0,
//                     focusElevation: 0,
//                     highlightElevation: 0,
//                     onPressed: () {
//                       Navigator.pop(context);
//                       showModalBottomSheet<void>(
//                         isScrollControlled: true,
//                         context: context,
//                         barrierColor: Colors.black.withOpacity(0.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(14.0),
//                               topRight: Radius.circular(14.0)),
//                         ),
//                         builder: (BuildContext context) {
//                           return tunjukkanQR(context);
//                         },
//                       );
//                     },
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     color: blackColor,
//                     splashColor: greyColor,
//                     child: Text(
//                       'Buat QR',
//                       style: nunitoTextStyle.copyWith(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w800,
//                         color: whiteColor,
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),
//           const SizedBox(
//             height: 24,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget tarikSaldo(context) {
//     showBank = true;
//     if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
//       showButton = false;
//     } else {
//       showButton = true;
//     }
//     return StatefulBuilder(builder: (context, setNewState) {
//       return SingleChildScrollView(
//         padding: EdgeInsets.only(
//             top: 24,
//             left: 16,
//             right: 16,
//             bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '💰Tarik Saldo',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 IconButton(
//                   padding: const EdgeInsets.only(left: 0),
//                   splashColor: greyColor,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close),
//                   color: blackColor,
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//               decoration: BoxDecoration(
//                 image: const DecorationImage(
//                   image: AssetImage("assets/bg_saldo.png"),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Saldo Anda',
//                         style: nunitoTextStyle.copyWith(
//                           color: whiteColor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(
//                     'Rp 1.000.000',
//                     style: nunitoTextStyle.copyWith(
//                       color: whiteColor,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 24,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             showBank == true
//                 ? Padding(
//                     padding: const EdgeInsets.all(0),
//                     child: Column(
//                       children: [
//                         const BankCard(
//                           id: "1",
//                           bank: "BCA",
//                           image: "assets/bca.png",
//                           name: "a/n Jalu Detya Wibawa",
//                           no: "11294940303",
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 38),
//                           width: double.infinity,
//                           height: 46,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             border: Border.all(
//                                 color: const Color(0xff94959B), width: 1),
//                           ),
//                           // ignore: deprecated_member_use
//                           child: RaisedButton(
//                             elevation: 0,
//                             hoverElevation: 0,
//                             focusElevation: 0,
//                             highlightElevation: 0,
//                             onPressed: () {
//                               handleShowBank();
//                               setNewState(() {
//                                 showBank = false;
//                               });
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             color: whiteColor,
//                             splashColor: greyColor,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(Icons.add),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   'Tambah Bank',
//                                   style: nunitoTextStyle.copyWith(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: greyColor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(0),
//                     child: Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: TextField(
//                             autocorrect: true,
//                             readOnly: true,
//                             keyboardType: TextInputType.number,
//                             style: nunitoTextStyle.copyWith(
//                               color: blackColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             onTap: () => showModalBottomSheet<void>(
//                               isScrollControlled: true,
//                               context: context,
//                               barrierColor: Colors.black.withOpacity(0.5),
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(14.0),
//                                     topRight: Radius.circular(14.0)),
//                               ),
//                               builder: (BuildContext context) {
//                                 return pilihBank(context);
//                               },
//                             ),
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 18, horizontal: 16),
//                               isDense: true,
//                               hintText: ' Pilih Bank',
//                               hintStyle: nunitoTextStyle.copyWith(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                               fillColor: whiteColor,
//                               suffixIcon: const Icon(
//                                 Icons.arrow_drop_down_outlined,
//                                 size: 30,
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide: BorderSide(
//                                     color: Color(0xffEAEAEA), width: 1.5),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide:
//                                     BorderSide(color: primaryColor, width: 1.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: TextField(
//                             autocorrect: true,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             textInputAction: TextInputAction.done,
//                             style: nunitoTextStyle.copyWith(
//                               color: blackColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 18, horizontal: 16),
//                               isDense: true,
//                               hintText: ' No Rekening (Pastikan Benar)',
//                               hintStyle: nunitoTextStyle.copyWith(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                               fillColor: whiteColor,
//                               enabledBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide: BorderSide(
//                                     color: Color(0xffEAEAEA), width: 1.5),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide:
//                                     BorderSide(color: primaryColor, width: 1.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: TextField(
//                             autocorrect: true,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             textInputAction: TextInputAction.done,
//                             style: nunitoTextStyle.copyWith(
//                               color: blackColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 18, horizontal: 16),
//                               isDense: true,
//                               hintText: ' Nama Rekening (Pastikan Benar)',
//                               hintStyle: nunitoTextStyle.copyWith(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                               fillColor: whiteColor,
//                               enabledBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide: BorderSide(
//                                     color: Color(0xffEAEAEA), width: 1.5),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 borderSide:
//                                     BorderSide(color: primaryColor, width: 1.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//             const SizedBox(
//               height: 16,
//             ),
//             showButton == true
//                 ? Container(
//                     margin: const EdgeInsets.only(bottom: 24),
//                     width: double.infinity,
//                     height: 56,
//                     decoration: const BoxDecoration(),
//                     // ignore: deprecated_member_use
//                     child: RaisedButton(
//                       elevation: 0,
//                       hoverElevation: 0,
//                       focusElevation: 0,
//                       highlightElevation: 0,
//                       onPressed: () {
//                         Navigator.pop(context);
//                         showModalBottomSheet<void>(
//                           // isScrollControlled: true,
//                           context: context,
//                           barrierColor: Colors.black.withOpacity(0.5),

//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(14.0),
//                                 topRight: Radius.circular(14.0)),
//                           ),
//                           builder: (BuildContext context) {
//                             return StatefulBuilder(
//                                 builder: (context, setNewState) {
//                               return tarikSaldoYakin(context);
//                             });
//                           },
//                         );
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       color: blackColor,
//                       splashColor: greyColor,
//                       child: Text(
//                         'Tarik Saldo',
//                         style: nunitoTextStyle.copyWith(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: whiteColor,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget pilihBank(context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
//       ),
//       child: Stack(
//         children: [
//           Row(
//             children: [
//               Container(
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.arrow_back_ios),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: Text(
//                   'Pilih Bank',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 64),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: TextFormField(
//               autocorrect: true,
//               style: nunitoTextStyle.copyWith(
//                 color: blackColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//               decoration: InputDecoration(
//                 isDense: true,
//                 hintText: ' Cari Bank',
//                 prefixIcon: const Icon(Icons.search_sharp, size: 26),
//                 hintStyle: nunitoTextStyle.copyWith(
//                   color: Colors.grey,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(14)),
//                   borderSide: BorderSide(color: Color(0xffEAEAEA), width: 1),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(14)),
//                   borderSide: BorderSide(color: primaryColor, width: 1),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 128),
//             height: MediaQuery.of(context).size.height * 0.5,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   for (var i = 0; i < 15; i++)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: Text(
//                         'BNI',
//                         style: nunitoTextStyle.copyWith(
//                           color: blackColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget tarikSaldoYakin(context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Apa anda yakin?',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 IconButton(
//                   padding: const EdgeInsets.only(left: 0),
//                   splashColor: greyColor,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close),
//                   color: blackColor,
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Saldo anda akan diproses untuk dikirim ke akun rekening anda dibawah ini',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff545454),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Bank',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'BCA',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nomor Rekening',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     '11294940303',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nama Pemilik',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Jalu Detya Wibawa',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                       border:
//                           Border.all(color: const Color(0xffE4E4E4), width: 1),
//                     ),

//                     // ignore: deprecated_member_use
//                     child: RaisedButton(
//                       elevation: 0,
//                       hoverElevation: 0,
//                       focusElevation: 0,
//                       highlightElevation: 0,
//                       onPressed: () async {},
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       color: whiteColor,
//                       splashColor: greyColor,
//                       child: Text(
//                         'Batalkan',
//                         style: nunitoTextStyle.copyWith(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: blackColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 14,
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     height: 56,
//                     decoration: const BoxDecoration(),
//                     // ignore: deprecated_member_use
//                     child: RaisedButton(
//                       elevation: 0,
//                       hoverElevation: 0,
//                       focusElevation: 0,
//                       highlightElevation: 0,
//                       onPressed: () {
//                         Navigator.pop(context);
//                         showModalBottomSheet<void>(
//                             isScrollControlled: true,
//                             context: context,
//                             barrierColor: Colors.black.withOpacity(0.5),
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(14.0),
//                                   topRight: Radius.circular(14.0)),
//                             ),
//                             builder: (BuildContext context) {
//                               return saldoSedang(context);
//                             });
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       color: blackColor,
//                       splashColor: greyColor,
//                       child: Text(
//                         'Ya yakin',
//                         style: nunitoTextStyle.copyWith(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: whiteColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget saldoSedang(context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '⌛️ Saldo Sedang Dikirim',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 IconButton(
//                   padding: const EdgeInsets.only(left: 0),
//                   splashColor: greyColor,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close),
//                   color: blackColor,
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Saldo anda sedang diproses untuk dikirim ke akun rekening anda, Silahkan menunggu 1x24 jam.',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff545454),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Bank',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'BCA',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nomor Rekening',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     '11294940303',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nama Pemilik',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Jalu Detya Wibawa',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Total Penarikan',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Rp 1.000.000',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               width: double.infinity,
//               height: 56,
//               decoration: const BoxDecoration(),
//               // ignore: deprecated_member_use
//               child: RaisedButton(
//                 elevation: 0,
//                 hoverElevation: 0,
//                 focusElevation: 0,
//                 highlightElevation: 0,
//                 onPressed: () => showModalBottomSheet<void>(
//                     isScrollControlled: true,
//                     context: context,
//                     barrierColor: Colors.black.withOpacity(0.5),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(14.0),
//                           topRight: Radius.circular(14.0)),
//                     ),
//                     builder: (BuildContext context) {
//                       return saldoBerhasil(context);
//                     }),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 color: blackColor,
//                 splashColor: greyColor,
//                 child: Text(
//                   'Okey',
//                   style: nunitoTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                     color: whiteColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget saldoBerhasil(context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Saldo Berhasil Dikirim 💰🥳',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 IconButton(
//                   padding: const EdgeInsets.only(left: 0),
//                   splashColor: greyColor,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close),
//                   color: blackColor,
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Saldo berhasil dikirim🥳, Silahkan cek saldo pada rekening anda.",
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff545454),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Bank',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'BCA',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nomor Rekening',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     '11294940303',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Nama Pemilik',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Jalu Detya Wibawa',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Total Penarikan',
//                     style: nunitoTextStyle.copyWith(
//                       color: const Color(0xff6B7280),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Rp 1.000.000',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               width: double.infinity,
//               height: 56,
//               decoration: const BoxDecoration(),
//               // ignore: deprecated_member_use
//               child: RaisedButton(
//                 elevation: 0,
//                 hoverElevation: 0,
//                 focusElevation: 0,
//                 highlightElevation: 0,
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 color: blackColor,
//                 splashColor: greyColor,
//                 child: Text(
//                   'Okey',
//                   style: nunitoTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                     color: whiteColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget tunjukkanQR(context) {
//     return SingleChildScrollView(
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.8,
//         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//         child: Column(
//           children: [
//             Text(
//               'Tunjukkan QR ke Customer',
//               style: nunitoTextStyle.copyWith(
//                 color: blackColor,
//                 fontSize: 22,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xffF2F2F2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 'Expired in 58 : 00 : 11',
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 28,
//             ),
//             Image.asset(
//               'assets/qr_code.png',
//               width: MediaQuery.of(context).size.width * 0.6,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Image.asset(
//               'assets/qris_support.png',
//               width: MediaQuery.of(context).size.width * 0.7,
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: Row(
//                   children: [
//                     Text(
//                       'Transaction Fee',
//                       style: nunitoTextStyle.copyWith(
//                         color: const Color(0xff6B7280),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.help_rounded,
//                         size: 20,
//                         color: const Color(0xffD1D5DB),
//                       ),
//                     ),
//                   ],
//                 )),
//                 Expanded(
//                   child: Text(
//                     'Rp 512',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: Row(
//                   children: [
//                     Text(
//                       'Total Tagihan',
//                       style: nunitoTextStyle.copyWith(
//                         color: const Color(0xff6B7280),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 )),
//                 Expanded(
//                   child: Text(
//                     'Rp 12.512',
//                     style: nunitoTextStyle.copyWith(
//                       color: blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 38,
//             ),
//             Container(
//               margin: const EdgeInsets.only(bottom: 24),
//               width: double.infinity,
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xffE4E4E4), width: 1),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               // ignore: deprecated_member_use
//               child: RaisedButton(
//                 elevation: 0,
//                 hoverElevation: 0,
//                 focusElevation: 0,
//                 highlightElevation: 0,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   showDialog<String>(
//                     context: context,
//                     builder: (BuildContext context) => Dialog(
//                       backgroundColor: const Color(0xffFFFFFF),
//                       insetPadding: const EdgeInsets.all(16),
//                       child: Stack(
//                         overflow: Overflow.visible,
//                         alignment: Alignment.center,
//                         children: <Widget>[
//                           Container(
//                             width: double.infinity,
//                             height: 170,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 24, horizontal: 16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Apa anda yakin?',
//                                       style: nunitoTextStyle.copyWith(
//                                         color: black2Color,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       padding: const EdgeInsets.only(left: 0),
//                                       splashColor: greyColor,
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       icon: const Icon(Icons.close),
//                                       color: black2Color,
//                                       iconSize: 30,
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         width: double.infinity,
//                                         height: 56,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(14),
//                                           border: Border.all(
//                                               color: const Color(0xffE4E4E4),
//                                               width: 1),
//                                         ),

//                                         // ignore: deprecated_member_use
//                                         child: RaisedButton(
//                                           elevation: 0,
//                                           hoverElevation: 0,
//                                           focusElevation: 0,
//                                           highlightElevation: 0,
//                                           onPressed: () async {},
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                           ),
//                                           color: whiteColor,
//                                           splashColor: greyColor,
//                                           child: Text(
//                                             'Batalkan',
//                                             style: nunitoTextStyle.copyWith(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w800,
//                                               color: blackColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 14,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         width: double.infinity,
//                                         height: 56,
//                                         decoration: const BoxDecoration(),
//                                         // ignore: deprecated_member_use
//                                         child: RaisedButton(
//                                           elevation: 0,
//                                           hoverElevation: 0,
//                                           focusElevation: 0,
//                                           highlightElevation: 0,
//                                           onPressed: () async {},
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                           ),
//                                           color: blackColor,
//                                           splashColor: greyColor,
//                                           child: Text(
//                                             'Ya yakin',
//                                             style: nunitoTextStyle.copyWith(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w800,
//                                               color: whiteColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 color: whiteColor,
//                 splashColor: greyColor,
//                 child: Text(
//                   'Batalkan Transaksi',
//                   style: nunitoTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                     color: blackColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of<AuthProvider>(context);
//     lengkapiDataDiri() {
//       return Container(
//         height: MediaQuery.of(context).size.height * 0.8,
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(14),
//             topRight: Radius.circular(14),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Lengkapi data diri',
//                   style: nunitoTextStyle.copyWith(
//                     color: blackColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 IconButton(
//                   padding: const EdgeInsets.only(left: 0),
//                   splashColor: greyColor,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close),
//                   color: blackColor,
//                   iconSize: 40,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: TextField(
//                 autocorrect: true,
//                 keyboardType: TextInputType.text,
//                 textCapitalization: TextCapitalization.sentences,
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 decoration: InputDecoration(
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                   isDense: true,
//                   hintText: ' Masukkan Nama Lengkap',
//                   hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
//                   fillColor: whiteColor,
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     borderSide:
//                         BorderSide(color: Color(0xffEAEAEA), width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(color: primaryColor, width: 1.5),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: TextField(
//                 autocorrect: true,
//                 keyboardType: TextInputType.text,
//                 textCapitalization: TextCapitalization.sentences,
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 decoration: InputDecoration(
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                   isDense: true,
//                   hintText: ' No HP',
//                   hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
//                   fillColor: whiteColor,
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     borderSide:
//                         BorderSide(color: Color(0xffEAEAEA), width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(color: primaryColor, width: 1.5),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Text(
//               'Upload identitas diri',
//               style: nunitoTextStyle.copyWith(
//                 color: blackColor,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Image.asset('assets/ktp_area.png'),
//             ),
//             const SizedBox(
//               height: 14,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(
//                   Icons.lock,
//                   color: greyColor,
//                   size: 14,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                   child: RichText(
//                     textAlign: TextAlign.left,
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                           text:
//                               "Kamu diwajibkan untuk verifikasi KTP, untuk mencegah orang lain menggunakan akunmu",
//                           style: nunitoTextStyle.copyWith(
//                               color: Color(0xff545454)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               width: double.infinity,
//               height: 56,
//               decoration: const BoxDecoration(),
//               // ignore: deprecated_member_use
//               child: RaisedButton(
//                 elevation: 0,
//                 hoverElevation: 0,
//                 focusElevation: 0,
//                 highlightElevation: 0,
//                 onPressed: () async {},
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 color: blackColor,
//                 splashColor: greyColor,
//                 child: Text(
//                   'Submit',
//                   style: nunitoTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                     color: whiteColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: bgColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(
//             vertical: 30,
//             horizontal: 16,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () async {
//                   await GoogleApi.logout()
//                       .then((value) => authProvider.logout(context));
//                 },
//                 splashColor: greyColor,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Hi, Bjorka Dolor',
//                           style: nunitoTextStyle.copyWith(
//                             color: blackColor,
//                             fontWeight: FontWeight.w800,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Welcome back to ...',
//                           style: nunitoTextStyle.copyWith(
//                             color: blackColor,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Image.asset(
//                       'assets/avatar.png',
//                       width: 56,
//                       height: 56,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                 onTap: () => showModalBottomSheet<void>(
//                     context: context,
//                     isScrollControlled: true,
//                     shape: const RoundedRectangleBorder(
//                       // borderRadius: BorderRadius.circular(14),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(14),
//                         topRight: Radius.circular(14),
//                       ),
//                     ),
//                     backgroundColor: Colors.white,
//                     builder: (BuildContext context) => lengkapiDataDiri()),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: const Color(0xFFF2F2F2),
//                       borderRadius: BorderRadius.circular(14)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Lengkapi data diri',
//                         style: nunitoTextStyle.copyWith(
//                           color: blackColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Icon(
//                         Icons.arrow_right_alt_outlined,
//                         size: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//                 decoration: BoxDecoration(
//                   image: const DecorationImage(
//                     image: AssetImage("assets/bg_saldo.png"),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Saldo Anda',
//                           style: nunitoTextStyle.copyWith(
//                             color: whiteColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                         showSaldo == true
//                             ? IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     showSaldo = false;
//                                   });
//                                 },
//                                 icon: Icon(
//                                   Icons.visibility_outlined,
//                                   size: 30,
//                                   color: whiteColor,
//                                 ),
//                               )
//                             : IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     showSaldo = true;
//                                   });
//                                 },
//                                 icon: Icon(
//                                   Icons.visibility_off_outlined,
//                                   size: 30,
//                                   color: whiteColor,
//                                 ),
//                               ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     showSaldo == true
//                         ? Text(
//                             'Rp 1.000.000',
//                             style: nunitoTextStyle.copyWith(
//                               color: whiteColor,
//                               fontWeight: FontWeight.w800,
//                               fontSize: 24,
//                             ),
//                           )
//                         : Text(
//                             '***********',
//                             style: nunitoTextStyle.copyWith(
//                               color: whiteColor,
//                               fontWeight: FontWeight.w800,
//                               fontSize: 24,
//                             ),
//                           ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () => showModalBottomSheet<void>(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(14),
//                                     topRight: Radius.circular(14),
//                                   ),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 builder: (BuildContext context) {
//                                   return tarikSaldo(context);
//                                 }),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.save_alt,
//                                   size: 24,
//                                   color: whiteColor,
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   'Tarik Saldo',
//                                   style: nunitoTextStyle.copyWith(
//                                     color: whiteColor,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             splashColor: greyColor,
//                             onTap: () => showModalBottomSheet<void>(
//                               // isScrollControlled: true,
//                               context: context,

//                               barrierColor: Colors.black.withOpacity(0.5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(14.0),
//                                     topRight: Radius.circular(14.0)),
//                               ),
//                               builder: (BuildContext context) {
//                                 return buatQR(context);
//                               },
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.qr_code,
//                                   size: 24,
//                                   color: whiteColor,
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   'Buat QR',
//                                   style: nunitoTextStyle.copyWith(
//                                     color: whiteColor,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               Text(
//                 'Riwayat Transaksi',
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 24,
//                 ),
//               ),

              
//               const SizedBox(
//                 height: 12,
//               ),
//               const HistoryCard(
//                 id: "1",
//                 wallet: "OVO",
//                 image: "assets/ovo.png",
//                 date: "12 June 2022 16 : 00",
//                 price: "Rp 104.000",
//                 status: "Diterima",
//               ),
//               // const HistoryCard(
//               //   id: "2",
//               //   wallet: "BCA",
//               //   image: "assets/bca.png",
//               //   date: "12 June 2022 16 : 00",
//               //   price: "Rp 104.000",
//               //   status: "Belum Dibayar",
//               // ),
//               // const HistoryCard(
//               //   id: "3",
//               //   wallet: "Gopay",
//               //   image: "assets/gopay.png",
//               //   date: "12 June 2022 16 : 00",
//               //   price: "Rp 104.000",
//               //   status: "Expired",
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
