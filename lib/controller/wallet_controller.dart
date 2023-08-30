import 'package:get/get.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/wallet_model.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sqflite/sqflite.dart';

class WalletController extends GetxController {
  var walletData = Wallet().obs;

  void setWalletData(Rx<Wallet> walletData) {
    this.walletData = walletData;
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
}
