import 'package:contact_app/UserData.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/Splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/counFull', arguments: <User>[]);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
