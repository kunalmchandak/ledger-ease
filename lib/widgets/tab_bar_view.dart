import 'package:finance_management/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TypeTabBar extends StatelessWidget {
  const TypeTabBar({super.key, required this.category, required this.monthYear});
  final String category;
  final String monthYear;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'Credit',
                ),
                Tab(
                  text: 'Debit',
                )
              ],
              unselectedLabelColor: Colors.white,
            ),
            Expanded(
                child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TransactionList(
                      category: category, type: 'credit', monthYear: monthYear),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TransactionList(
                      category: category, type: 'debit', monthYear: monthYear),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
