class Transaction {
  final int id;
  final String name;
  final double amount;
  final DateTime time;

  Transaction(
      {required this.id,
      required this.name,
      required this.amount,
      required this.time});
}
