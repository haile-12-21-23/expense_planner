import 'package:flutter/material.dart';

Future<Future> asyncConfirmDialog(
    {required BuildContext context,
    required List<Widget> actions,
    required String title,
    required String content}) async {
  return showDialog(
    useSafeArea: true,
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: actions);
    },
  );
}
