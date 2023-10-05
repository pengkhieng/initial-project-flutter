import 'package:annotation/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 1200),
      () {
        Get.offAllNamed(Routes.HOME_PAGE);
      },
    );
  }
}
