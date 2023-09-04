import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/payment_card_model.dart';
import 'package:pumpit/model/transaction_model.dart';
import 'package:pumpit/model/user_model.dart';
import 'package:pumpit/model/wallet_model.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sqflite/sqflite.dart';

class WalletController extends GetxController {
  var walletData = Wallet().obs;
  var transactionData = Transactions().obs;
  RxInt selectedId = 0.obs;
  RxInt selectedCardId = 0.obs;
  TextEditingController walletController = TextEditingController();

  void setWalletData(Rx<Wallet> walletData) {
    this.walletData = walletData;
    update();
  }

  void setTransactionData(Rx<Transactions> transactionData) {
    this.transactionData = transactionData;
    update();
  }

  Future<void> getWalletData() async {
    String? userId = Preference.getString(Preference.userId);
    Database db = await DatabaseHelper.instance.database;
    var wallet = await db.query(
      'wallet', where: 'userid = ?', // WHERE clause
      whereArgs: [userId], limit: 1,
    );

    print(wallet);
    walletData.value = Wallet.fromMap(wallet[0]);
    setWalletData(walletData);
    update();
  }

  // Future<void> getTransactionData() async {
  //   String? userId = Preference.getString(Preference.userId);
  //   Database db = await DatabaseHelper.instance.database;
  //   var transaction = await db.query(
  //     'transaction', where: 'userid = ?', // WHERE clause
  //     whereArgs: [userId], limit: 1,
  //   );

  //   print(transaction);
  //   transactionData.value = Transactions.fromMap(transaction[0]);
  //   setTransactionData(transactionData);
  //   update();
  // }

  Future<List<TransactionResult>> getTransactionData() async {
    var userid = Preference.getString(Preference.userId);
    Database db = await DatabaseHelper.instance.database;

    const query = '''
    SELECT *
    FROM transactions
    INNER JOIN users ON transactions.userid = users.id
    INNER JOIN cards ON transactions.cardid = cards.cardid
    INNER JOIN wallet ON transactions.walletid = wallet.walletid
    WHERE transactions.userid = ?
  ''';

    var transactions = await db.rawQuery(query, [userid]);

    List<Map<String, dynamic>> result = [];

    for (var transactionMap in transactions) {
      var transaction = Transactions.fromMap(transactionMap);
      var user = User.fromMap(transactionMap);
      var card = PaymentCard.fromMap(transactionMap);

      var formattedTransaction = {
        'transactions': transaction.toMap(),
        'users': user.toMap(),
        'cards': card.toMap(),
      };

      result.add(formattedTransaction);
    }

    List<TransactionResult> transactionList =
        List.from(result.map((data) => TransactionResult.fromMap(data)));

    return transactionList;
  }
}
