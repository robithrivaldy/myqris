import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyData extends StatelessWidget {
  // final String title;
  // final String content;
  // const EmptyData({required this.title, required this.content}) : super();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/empty.png',
                        width: MediaQuery.of(context).size.width * .55,
                        fit: BoxFit.fill,
                      ),
                      /*SvgPicture.asset(
                    "assets/images/empty.png",
                    width: MediaQuery.of(context).size.width * .50,
                  ),*/
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Container(
                  //     child:
                  //     Column(
                  //       children: [
                  //         Text(title,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black87)),
                  //         SizedBox(height: 5,),
                  //         Text(content,textAlign: TextAlign.center,style: GoogleFonts.poppins(fontWeight: FontWeight.w300,fontSize: 14,color: Colors.grey))
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      );
}
