import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTransaction;
  TransactionList({required this.transactions, required this.delTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(children: [
          Container(
            child: Card(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding: EdgeInsets.all(10.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.purple),
                    ),
                    child: Text(
                      '\$ ${transactions[index].amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        DateFormat.yMd().format(transactions[index].time),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {
                        delTransaction(transactions[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          )
        ]);
      },
      itemCount: transactions.length,
    );
  }
}
