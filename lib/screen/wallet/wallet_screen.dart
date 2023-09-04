import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/payment_card_controller.dart';
import 'package:pumpit/controller/wallet_controller.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/payment_card_model.dart';
import 'package:pumpit/model/transaction_model.dart';
import 'package:pumpit/screen/shared/button_shared.dart';
import 'package:pumpit/screen/shared/text_form_shared.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletController w = Get.put(WalletController());
  PaymentCardController p = Get.put(PaymentCardController());

  @override
  void initState() {
    super.initState();
    w.getWalletData();
  }

  Future<int> updateWalletAmount(double newAmount, int walletId) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> results = await db.query('wallet',
        columns: ['amount'], where: 'walletid = ?', whereArgs: [walletId]);

    double currentAmount = results.first['amount'];
    double updatedAmount = currentAmount + newAmount;

    return await db.update(
      'wallet',
      {'amount': updatedAmount},
      where: 'walletid = ?',
      whereArgs: [walletId],
    );
  }

  void _showBtmSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(4.2.w),
                child: const Text('Add wallet amount'),
              ),
              SharedTextFormNoContainer(
                title: 'Enter Amount',
                hintText: '12345.67',
                controller: w.walletController,
              ),
              FutureBuilder<List<PaymentCard>>(
                future: p.getPaymentCard(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Display a loading indicator
                  } else if (snapshot.hasError) {
                    return const Text(
                        'Error loading options'); // Display an error message
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                        'No cards available'); // Display a message if no data
                  } else {
                    List<PaymentCard> cards = snapshot.data!;
                    return Column(
                      children: cards.map((card) {
                        return ListTile(
                            title: Text(card.cardname!),
                            subtitle: Text(
                              p.formatCreditCardNumber(card.cardnum!),
                              style: const TextStyle(letterSpacing: 2.5),
                            ),
                            leading: Obx(() {
                              return Radio<int>(
                                value: card.cardid!,
                                groupValue: w.selectedId.value,
                                onChanged: (int? value) {
                                  setState(() {
                                    w.selectedId.value = value!;
                                    w.selectedCardId.value = card.cardid!;
                                  });
                                },
                              );
                            }));
                      }).toList(),
                    );
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.all(4.2.w),
                  child: Obx(() {
                    return TextButton(
                      onPressed: w.selectedId.value != -1
                          ? () async {
                              await updateWalletAmount(
                                      double.parse(w.walletController.text),
                                      w.walletData.value.walletid!)
                                  .then((value) {
                                Get.back();
                                setState(() {});
                              }).then((value) async {
                                await DatabaseHelper.instance.addTransaction(
                                  Transactions(
                                    transactionid: Random().nextInt(100000) + 1,
                                    userid: int.parse(Preference.getString(
                                        Preference.userId)!),
                                    cardid: w.selectedCardId.value,
                                    walletid: w.walletData.value.walletid,
                                    transactionsamount:
                                        double.parse(w.walletController.text),
                                    transactionType: 'Credit',
                                    transactionDate: DateTime.now().toString(),
                                  ),
                                );
                              });
                            }
                          : () {},
                      child: const Text(
                        'Save',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  })),
            ],
          );
        }).then((value) {
      w.walletController.clear();
      w.getWalletData();
      w.selectedId.value = -1;
      w.selectedCardId.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 2.1.w),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(4.2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'My Wallet',
                          style: TextStyle(fontSize: 25, color: primaryColor),
                        ),
                        Text(
                          "RM ${w.walletData.value.amount.toString()}",
                          style: const TextStyle(
                              fontSize: 20, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SharedButton(
                paddingValue: 2.1.w,
                title: 'Add Wallet',
                onTap: () {
                  _showBtmSheet();
                },
              ),
              divider(),
              const Text('Transaction List', style: TextStyle(fontSize: 18)),
              FutureBuilder<List<TransactionResult>>(
                  future: w.getTransactionData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TransactionResult>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? const Center(child: Text('No Transaction in List'))
                        : Padding(
                            padding: EdgeInsets.all(4.2.w),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ExpansionTile(
                                    maintainState: true,
                                    onExpansionChanged: (bool isExpanded) {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    title: Text(
                                      "Transaction ID: ${snapshot.data![i].transactions!.transactionid.toString()}",
                                    ),
                                    subtitle: Text(
                                      "Amount: ${snapshot.data![i].transactions!.transactionsamount!.toString()}",
                                    ),
                                    trailing: const Icon(
                                      Icons.add,
                                    ),
                                    leading: snapshot.data![i].transactions!
                                                .transactionType ==
                                            'Debit'
                                        ? const Icon(
                                            Icons.arrow_downward_rounded,
                                            color: Colors.red)
                                        : const Icon(Icons.arrow_upward_rounded,
                                            color: Colors.green),
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Transaction Date: ${snapshot.data![i].transactions!.transactionDate!}",
                                            ),
                                            Text(
                                              "Card Used: ${snapshot.data![i].paymentCard!.cardname}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget divider() {
    return Divider(
      indent: 4.2.w,
      endIndent: 4.2.w,
      color: greyLess,
    );
  }
}
