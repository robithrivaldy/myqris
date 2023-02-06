// import 'package:myqris/pages/detail_transaction_page.dart';
// import 'package:myqris/utils/constants.dart';
// import 'package:flutter/material.dart';

// class BankCard extends StatelessWidget {
//   final int id;
//   final String bank;
//   final String image;
//   final String name;
//   final String no;
//   const BankCard({
//     Key? key,
//     required this.id,
//     required this.bank,
//     required this.image,
//     required this.name,
//     required this.no,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: greyColor.withOpacity(0.2),
//               spreadRadius: 3,
//               blurRadius: 6,
//               offset: const Offset(1, 3) // changes position of shadow
//               ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             image,
//             width: 36,
//             height: 36,
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 bank,
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 name,
//                 style: nunitoTextStyle.copyWith(
//                   color: blackColor.withOpacity(0.4),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//           Spacer(),
//           Text(
//             no,
//             style: nunitoTextStyle.copyWith(
//               color: blackColor,
//               fontWeight: FontWeight.w800,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
