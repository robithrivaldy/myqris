import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LazyAntrian extends StatelessWidget {
  Widget _widgetInfo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: SizedBox(
          height: 10,
        )),
        Expanded(
            child: Container(
          height: 10,
        )),
      ],
    );
  }

  Widget _containerItem(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget shimmer(child) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        period: Duration(seconds: 2),
        child: child,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        // for (var i = 0; i < 5; i++)
        //   shimmer(
        //     Container(
        //       margin: const EdgeInsets.all(20),
        //       width: MediaQuery.of(context).size.width,
        //       height: 90,
        //       child: _containerItem(
        //         _widgetInfo(),
        //       ),
        //     ),
        //   ),

        shimmer(
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: _containerItem(
              _widgetInfo(),
            ),
          ),
        ),
        shimmer(
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: _containerItem(
              _widgetInfo(),
            ),
          ),
        ),
        shimmer(
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: _containerItem(
              _widgetInfo(),
            ),
          ),
        ),

        shimmer(
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 20,
            child: _containerItem(
              _widgetInfo(),
            ),
          ),
        ),

        shimmer(
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: _containerItem(
              _widgetInfo(),
            ),
          ),
        ),
      ],
    );
  }
}
