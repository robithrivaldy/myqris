import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Image.asset(
            'assets/signal.png',
            width: 100,
          ),
        ),
      ),
    );
  }
}
