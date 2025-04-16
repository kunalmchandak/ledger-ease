import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    final Stream<QuerySnapshot> transactionsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        centerTitle: true,
        title: const Text(
          "Finance Charts",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        elevation: 4,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: transactionsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.amber));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No transactions found.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final docs = snapshot.data!.docs;
          double totalCredit = 0;
          double totalDebit = 0;
          Map<String, double> monthlyTotals = {};

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            final double amount = (data['amount'] ?? 0).toDouble();
            final String type = data['type'] ?? 'debit';
            final String monthyear = data['monthyear'] ?? 'Unknown';

            if (type == 'credit') {
              totalCredit += amount;
              monthlyTotals[monthyear] = (monthlyTotals[monthyear] ?? 0) + amount;
            } else {
              totalDebit += amount;
              monthlyTotals[monthyear] = (monthlyTotals[monthyear] ?? 0) - amount;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Credit vs Debit",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 200,
                    child: _PieChartWidget(
                      credit: totalCredit,
                      debit: totalDebit,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Monthly Net Amount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                String formattedValue;

                                if (value >= 100000 || value <= -100000) {
                                  formattedValue = '${(value / 100000).toStringAsFixed(1)}L';
                                } else if (value >= 1000 || value <= -1000) {
                                  formattedValue = '${(value / 1000).toStringAsFixed(1)}k';
                                } else {
                                  formattedValue = value.toStringAsFixed(0);
                                }

                                return Text(
                                  formattedValue,
                                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              )
                            ),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                )
                            ),
                            bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < monthlyTotals.keys.length) {
                                  return Text(
                                    monthlyTotals.keys.elementAt(index).substring(0, 3),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(
                          monthlyTotals.length,
                              (i) => BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: monthlyTotals.values.elementAt(i),
                                color: monthlyTotals.values.elementAt(i) >= 0 ? Colors.green : Colors.red,
                                width: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PieChartWidget extends StatelessWidget {
  final double credit;
  final double debit;

  const _PieChartWidget({
    required this.credit,
    required this.debit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: credit,
            color: Colors.green,
            title: 'Credit\n₹${credit.toStringAsFixed(1)}',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          PieChartSectionData(
            value: debit,
            color: Colors.red,
            title: 'Debit\n₹${debit.toStringAsFixed(1)}',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
