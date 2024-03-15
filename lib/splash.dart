import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jombay/jombay_list.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const JombayList()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset("assets/images/images.jpg"),
        ),
      ),
    );
  }
}
