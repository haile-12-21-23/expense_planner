import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions});
  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
              child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2)),
                child: Text(
                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}
