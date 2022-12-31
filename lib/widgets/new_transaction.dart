import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTx;
  NewTransaction({super.key, required this.addNewTx});
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
    addNewTx(enteredTitle, enteredAmount);
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
