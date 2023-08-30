import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/wallet_controller.dart';
import 'package:pumpit/screen/shared/shared_button.dart';
import 'package:sizer/sizer.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletController w = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    w.getWalletData();
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
                title: 'Add Wallet',
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
