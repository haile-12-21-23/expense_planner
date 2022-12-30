import '../model/transaction.dart';

import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 75.97,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Grocery',
      amount: 15.97,
      date: DateTime.now(),
    )
  ];
  void addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: 'tx${userTransactions.length + 2}',
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTx: addNewTransaction),
        TransactionList(
          transactions: userTransactions,
        )
      ],
    );
  }
}
