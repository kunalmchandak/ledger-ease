// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/screens/login.dart';
import 'package:finance_management/widgets/add_transaction_form.dart';
import 'package:finance_management/widgets/hero_card.dart';
import 'package:finance_management/widgets/transactions_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

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

  final userId = FirebaseAuth.instance.currentUser!.uid;

  _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.black,
            content: AddTransactionForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(' ');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text(' ');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(' ');
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber.shade700,
            onPressed: (() {
              _dialogBuilder(context);
            }),
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeroCard(userId: userId),
                TransactionsCard(),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.amber.shade600,
            title: Text(
              'Hello ${data['username']}',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 36),
            ),
            actions: [
              IconButton(
                  highlightColor: Colors.white24,
                  hoverColor: Colors.black12,
                  iconSize: 35,
                  onPressed: () {
                    logOut();
                  },
                  icon: isLogoutLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        )
                      : const Icon(Icons.logout),
                  color: Colors.black87)
            ],
          ),
        );
      },
    );
  }
}
