import 'package:expense_planner/constants/utils.dart';
import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList(
      {super.key, required this.transactions, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transaction added yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text(
                            '\$${(transactions[index].amount).toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    tooltip: 'Delete from list',
                    color: Theme.of(context).errorColor,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      asyncConfirmDialog(
                          context: context,
                          actions: [
                            TextButton(
                                onPressed: () {
                                  deleteTx(transactions[index].id);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete',
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                    ))),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    )))
                          ],
                          title:
                              '${transactions[index].title} will be deleted!',
                          content: 'Make sure!, this is can\'t undo');
                    },
                  ),
                ),
              );
            },
          );
  }
}
