import 'dart:ui';

import 'package:flutter/services.dart';

import '../model/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 75.97,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Grocery',
    //   amount: 15.97,
    //   date: DateTime.now(),
    // )
  ];
  bool showChart = false;
  Iterable<Transaction> get recentTransactions {
    return userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        id: 'tx${userTransactions.length + 2}',
        title: txTitle,
        amount: txAmount,
        date: selectedDate);
    setState(() {
      userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addNewTx: addNewTransaction),
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
        title: const Text(
          'Personal Expense',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
            tooltip: 'Add new Transactions',
            icon: const Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ]);
    final transactionListWidget = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transactions: userTransactions,
        deleteTx: deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch(
                    value: showChart,
                    onChanged: (value) {
                      setState(() {
                        showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandScape)
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(
                  recentTransactions: recentTransactions.toList(),
                ),
              ),
            if (!isLandScape) transactionListWidget,
            if (isLandScape)
              showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(
                        recentTransactions: recentTransactions.toList(),
                      ),
                    )
                  : transactionListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new Transactions',
        child: const Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
