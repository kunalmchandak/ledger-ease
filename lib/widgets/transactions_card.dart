import 'package:finance_management/utils/icons_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  TransactionCard({
    super.key,
    required this.data,
  });
  final dynamic data;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  var appIcons = AppIcons();

  String formatAmount(dynamic amount) {
    double value = 0;
    if (amount is String) {
      value = double.tryParse(amount) ?? 0;
    } else if (amount is num) {
      value = amount.toDouble();
    }
    if (value.abs() >= 100000) {
      return '${(value / 100000).toStringAsFixed(1)}L';
    } else if (value.abs() >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  // _dialogBuilder(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           backgroundColor: Colors.black,
  //           content: UpdateTransaction(),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['timestamp']);
    String formattedDate = DateFormat('d MMM hh:mma').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                color: Colors.grey.withOpacity(0.09),
                blurRadius: 10.0,
                spreadRadius: 4.0,
              )
            ]),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 13, vertical: 0.0),
          leading: SizedBox(
            width: 70,
            height: 90,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.data['type'] == 'credit'
                    ? Colors.green.withOpacity(0.4)
                    : Colors.red.withOpacity(0.4),
              ),
              child: Center(
                child: FaIcon(
                    appIcons
                        .getExpenseCategoryIcons('${widget.data['category']}'),
                    color: widget.data['type'] == 'credit'
                        ? Colors.green
                        : Colors.red),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.data['title']}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              Text(
                '${widget.data['type'] == 'credit' ? '+' : '-'} ₹ ${formatAmount(widget.data['amount'])}',
                style: TextStyle(
                    color: widget.data['type'] == 'credit'
                        ? Colors.green
                        : Colors.red),
              )
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Balance',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                  ),
                  Spacer(),
                  Text(
                    '₹ ${formatAmount(widget.data['remainingAmount'])}',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                  )
                ],
              ),
              Text(
                formattedDate,
                style: TextStyle(color: Colors.blueGrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
