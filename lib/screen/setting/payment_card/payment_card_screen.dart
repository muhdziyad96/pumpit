import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/payment_card_controller.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/payment_card_model.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sizer/sizer.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({super.key});

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  PaymentCardController c = Get.put(PaymentCardController());

  void _showBtmSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.2.w),
                  child: const Text('Add new card'),
                ),
                addCardFormField(
                  title: 'Card Name',
                  hintText: 'Muhammad Hafiy Azhar',
                  controller: c.cardnameController,
                ),
                addCardFormField(
                    title: 'Card Number',
                    hintText: '1234 5678 9012',
                    controller: c.cardnumController,
                    onChanged: c.onCardNumberChanged,
                    maxLength: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: addCardFormField(
                        title: 'Expired Date',
                        hintText: '07/2024',
                        controller: c.expDateController,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(c.isMasterCard.value
                          ? 'Master Card'
                          : c.isVisa.value
                              ? 'Visa'
                              : ''),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(4.2.w),
                  child: TextButton(
                    onPressed: () async {
                      await DatabaseHelper.instance
                          .addCard(
                        PaymentCard(
                          userid: int.parse(
                              Preference.getString(Preference.userId)!),
                          cardname: c.cardnameController.text,
                          cardnum: c.cardnumController.text,
                          expDate: c.expDateController.text,
                          cardType: c.isMasterCard.value
                              ? 'Master Card'
                              : c.isVisa.value
                                  ? 'Visa'
                                  : '',
                          // cardname: 'Zaxssx',
                          // cardnum: '31231412313213',
                          // expDate: '04/32',
                          // cardType: 'Master Card',
                        ),
                      )
                          .then((value) {
                        Get.back();
                        setState(() {});
                      });
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            );
          });
        }).then((value) {
      c.isMasterCard.value = false;
      c.isVisa.value = false;
      c.cardnameController.clear();
      c.cardnumController.clear();
      c.expDateController.clear();
    });
  }

  Widget addCardFormField({
    required String title,
    TextEditingController? controller,
    String? hintText,
    IconData? icon,
    String? errorText,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.2.w),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
          label: Text(title),
          errorText: errorText,
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.2.w),
          hintText: hintText,
          suffixIcon: InkWell(
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16, color: primaryColor),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment Card')),
      floatingActionButton: FloatingActionButton(
          heroTag: 'paymentCardScreen',
          child: const Icon(Icons.add),
          onPressed: () async {
            _showBtmSheet();
            // await DatabaseHelper.instance.addCard(
            //   PaymentCard(
            //       cardname: "test",
            //       userid: int.parse(Preference.getString(Preference.userId)!)),
            // );
          }),
      body: Center(
        child: FutureBuilder<List<PaymentCard>>(
            future: c.getPaymentCard(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PaymentCard>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Card in List'))
                  : Padding(
                      padding: EdgeInsets.all(4.2.w),
                      child: ListView(
                        children: snapshot.data!.map((card) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: Key(card.cardid.toString()),
                            onDismissed: (direction) {
                              setState(() {
                                DatabaseHelper.instance
                                    .removeCard(card.cardid!);
                                snapshot.data!.remove(card);
                              });
                            },
                            background: Container(color: Colors.red),
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                  color: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                              .toInt())
                                      .withOpacity(0.3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.5.h, left: 4.2.w),
                                        child: Text(
                                          c.formatCreditCardNumber(
                                              card.cardnum!),
                                          style: const TextStyle(
                                              letterSpacing: 2.5),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(4.2.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(card.cardname!),
                                            Text(card.expDate!),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 4.2.w, bottom: 4.2.w),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(card.cardType!),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }).toList(),
                      ),
                    );
            }),
      ),
    );
  }

  Widget txtField({
    TextEditingController? controller,
    String? hintText,
    IconData? icon,
    bool? obscureText,
    TextInputType? keyboardType,
    void Function()? onTap,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 4.2.w),
      child: TextFormField(
        onChanged: onChanged ?? (String value) {},
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: InkWell(
            onTap: onTap ?? () {},
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
