import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/payment_card_model.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sqflite/sqlite_api.dart';

class PaymentCardController extends GetxController {
  bool _isMasterCard(String cardNumber) {
    return RegExp(r'^5[1-5][0-9]{14}$').hasMatch(cardNumber);
  }

  bool _isVisa(String cardNumber) {
    return RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(cardNumber);
  }

  final RxBool isMasterCard = false.obs;
  final RxBool isVisa = false.obs;
  TextEditingController cardnameController = TextEditingController();
  TextEditingController cardnumController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cardTypeController = TextEditingController();

  void onCardNumberChanged(String value) {
    isMasterCard.value = _isMasterCard(value);
    isVisa.value = _isVisa(value);
  }

  String formatCreditCardNumber(String input) {
    if (input.length != 16) {
      // Handle incorrect input length
      return input;
    }

    final List<String> groups = [];
    for (int i = 0; i < 16; i += 4) {
      groups.add(input.substring(i, i + 4));
    }

    return groups.join(' ');
  }

  Future<List<PaymentCard>> getPaymentCard() async {
    var userid = Preference.getString(Preference.userId);
    Database db = await DatabaseHelper.instance.database;

    const query = '''
    SELECT *
    FROM cards
    INNER JOIN users ON cards.userid = users.id
    WHERE cards.userid = ?
    ORDER BY cards.cardname
    ''';

    var paymentCard = await db.rawQuery(query, [userid]);

    List<PaymentCard> cardList = paymentCard.isNotEmpty
        ? paymentCard.map((c) => PaymentCard.fromMap(c)).toList()
        : [];

    return cardList;
  }
}
