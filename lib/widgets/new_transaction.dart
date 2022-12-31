import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;
  const NewTransaction({super.key, required this.addNewTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitList() {
    final enteredTitle = titleController.text.trim();
    final enteredAmount = (amountController.text).isNotEmpty
        ? double.parse(amountController.text.trim())
        : 0;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredAmount.isNaN) {
      return;
    }
    widget.addNewTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitList(),
              // onChanged: (value) {
              //   inputTitle = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitList(),
              // onChanged: (value) {
              //   inputAmount = value;
              // },
            ),
            TextButton(
              onPressed: submitList,
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
