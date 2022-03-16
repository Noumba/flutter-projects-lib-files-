import 'package:expenseapp/widgets/chart.dart';
import 'package:expenseapp/widgets/new_transaction.dart';
import 'package:expenseapp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueGrey,
          cardTheme:
              CardTheme(color: Colors.white70.withOpacity(0.9), elevation: 0.0),
          accentColor: Colors.orange,
          backgroundColor: Colors.grey.shade400.withOpacity(0.2),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade900.withOpacity(0.7))),
      home: MyHomePage(title: 'Expense App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool switchValue = false;
  bool showChartBar = false;

  var transactions = [
    Transaction(
        name: 'Grocery sales', amount: 54.45, time: DateTime.now(), id: 1),
    Transaction(name: 'iPhone XR', amount: 589.8, time: DateTime.now(), id: 2),
  ];

  void _addNewTranscation(String title, double amount, DateTime date) {
    var transID = transactions.last.id + 1;
    final newTxn =
        Transaction(id: transID, name: title, amount: amount, time: date);

    setState(() {
      transactions.add(newTxn);
    });
  }

  List<Transaction> get recentTransactions {
    return transactions.where((txn) {
      return txn.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startNewTransaction() {
    showModalBottomSheet(
        context: (context),
        builder: (bctx) {
          return NewTransaction(addTxn: _addNewTranscation);
        });
  }

  void _deleteTransaction(id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _landScapeView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('show chart '),
                Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = !switchValue;
                        showChartBar = !showChartBar;
                      });
                    }),
              ],
            )),
        showChartBar == true
            ? Container(
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: Chart(recenttransactions: recentTransactions))
            : Container(),
        Container(
          height: showChartBar == true
              ? (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3
              : (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9,
          child: TransactionList(
            transactions: transactions,
            delTransaction: _deleteTransaction,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var view = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _startNewTransaction();
              },
              icon: Icon(
                Icons.add,
                size: 35,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startNewTransaction();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: view == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      color: Theme.of(context).backgroundColor,
                      height: (MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.3,
                      child: Chart(recenttransactions: recentTransactions)),
                  Container(
                    color: Theme.of(context).backgroundColor,
                    height: (MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransactionList(
                      transactions: transactions,
                      delTransaction: _deleteTransaction,
                    ),
                  ),
                ],
              )
            : _landScapeView(),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
