import 'package:pumpit/model/payment_card_model.dart';
import 'package:pumpit/model/user_model.dart';

class Transactions {
  int? transactionid;
  int? userid;
  int? walletid;
  int? cardid;
  double? transactionsamount;
  String? transactionType;
  String? transactionDate;
  User? users;
  Transactions? transactions;
  PaymentCard? paymentCard;

  Transactions({
    this.transactionid,
    this.userid,
    this.walletid,
    this.cardid,
    this.transactionsamount,
    this.transactionType,
    this.transactionDate,
    this.transactions,
    this.users,
    this.paymentCard,
  });

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
        transactionid: json['transactionid'],
        userid: json['userid'],
        walletid: json['walletid'],
        cardid: json['cardid'],
        transactionsamount: json['transactionsamount'],
        transactionType: json['transactionType'],
        transactionDate: json['transactionDate'],
      );

  Map<String, dynamic> toMap() {
    return {
      'transactionid': transactionid,
      'userid': userid,
      'walletid': walletid,
      'cardid': cardid,
      'transactionsamount': transactionsamount,
      'transactionType': transactionType,
      'transactionDate': transactionDate,
    };
  }
}

class TransactionResult {
  User? users;
  Transactions? transactions;
  PaymentCard? paymentCard;

  TransactionResult({
    this.transactions,
    this.users,
    this.paymentCard,
  });

  factory TransactionResult.fromMap(Map<String, dynamic> json) =>
      TransactionResult(
        transactions: Transactions.fromMap(json['transactions']),
        users: User.fromMap(json["users"]),
        paymentCard: PaymentCard.fromMap(json["cards"]),
      );

  Map<String, dynamic> toMap() {
    return {
      'transactions': transactions!.toMap(),
      'users': users!.toMap(),
      'Card': paymentCard!.toMap(),
    };
  }
}
