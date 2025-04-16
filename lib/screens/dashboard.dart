// ignore_for_file: use_build_context_synchronously

import 'package:finance_management/screens/stats_screen.dart';
import 'package:finance_management/screens/home_screen.dart';
import 'package:finance_management/screens/login.dart';
import 'package:finance_management/screens/transaction_screen.dart';
import 'package:finance_management/widgets/navbar.dart';
// import 'package:finance_management/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  int currentIndex = 1;
  final pageController = PageController(initialPage: 1);
  var pageViewList = [TransactionScreen(), const HomeScreen(), StatsPage()];

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();

    setState(() {
      isLogoutLoading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: Navbar(
          selectedIndex: currentIndex,
          onDestinationSelected: (int value) {
            setState(() {
              currentIndex = value;
              pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        children: pageViewList,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

