import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/user_controller.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserController u = Get.find();

  @override
  void initState() {
    super.initState();
    u.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(2.1.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 2.1.w),
                child: Text(
                  "Hi, ${u.userData.value.name ?? "Loading..."}",
                  style: const TextStyle(
                      fontSize: 28,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              );
            }),
            ListView(
              shrinkWrap: true,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current petrol price',
                            style: TextStyle(fontSize: 25, color: primaryColor),
                          ),
                          Text(
                            '3 August 2023 to 9 August 2023',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          const Text(
                            'RON95 : RM2.05 per litre',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          const Text(
                            'RON97 : RM3.37 per litre',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          const Text(
                            'Diesel : RM2.15 per litre',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Claim your rewards',
                            style: TextStyle(fontSize: 25, color: primaryColor),
                          ),
                          Text(
                            'View your progress',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Redeem points',
                            style: TextStyle(fontSize: 25, color: primaryColor),
                          ),
                          Text(
                            'Claim a lots of fun gifts and items',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
