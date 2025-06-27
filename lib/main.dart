import 'package:contact_app/Home_Screen_Counf_Full.dart';
import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import 'Splash_screen.dart';
import 'bottom_nav_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        BottomNavBarScreen.routeName: (_) => BottomNavBarScreen(),
        HomeScreenCounfFull.routeName: (_) => HomeScreenCounfFull(users: []),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
