import 'package:expenseapp/models/Transaction.dart';
import 'package:expenseapp/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;

  Chart({required this.recenttransactions});

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recenttransactions.length; i++) {
        if (recenttransactions[i].time.day == weekDay.day &&
            recenttransactions[i].time.weekday == weekDay.weekday &&
            recenttransactions[i].time.month == weekDay.month) {
          totalSum += recenttransactions[i].amount;
        }
      }
      return {
        'day': (DateFormat.E().format(weekDay)).toString().substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransaction.fold(0.0, (prevsValue, element) {
      return prevsValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: groupedTransaction.map((e) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                label: e['day'] as String,
                spendingAmount: e['amount'] as double,
                spendingPctOfTotal: maxSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / maxSpending),
          );
        }).toList(),
      ),
    );
  }
}
