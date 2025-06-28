import 'package:contact_app/UserData.dart';
import 'package:contact_app/colors.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_bar_screen.dart';
import 'home_screen_counf_full.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Image.asset("assets/images/logo.png", width: 100),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/home_logo.gif",
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            Text(
              "There is No Contacts Added Here",
              style: TextStyle(
                color: AppColors.buttonsColors,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonsColors,
        child: Icon(Icons.add, color: AppColors.background),
        onPressed: () => showAddContactSheet(context),
      ),
    );
  }

  void showAddContactSheet(BuildContext context) async {
    final newUser = await showModalBottomSheet<User>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BottomNavBarScreen(),
    );

    if (newUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreenCounfFull(users: [newUser]),
        ),
      );
    }
  }
}
