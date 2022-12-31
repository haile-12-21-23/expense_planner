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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewTransaction(addNewTx: addNewTransaction),
        // TransactionList(
        //   transactions: userTransactions,
        // )
      ],
    );
  }
}
