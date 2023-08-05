import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.1.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(3.5.w),
                  child: const Center(
                    child: Text(
                      'Add Payment Card',
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(3.5.w),
                  child: const Center(
                    child: Text(
                      'Help Centre',
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(3.5.w),
                  child: const Center(
                    child: Text(
                      'Legal',
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(3.5.w),
                  child: const Center(
                    child: Text(
                      'Change Language',
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: InkWell(
                onTap: () {
                  Get.offNamed('/login');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(3.5.w),
                    child: const Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 20, color: primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
              child: Padding(
                padding: EdgeInsets.all(3.5.w),
                child: const Center(
                  child: Text(
                    'V.1.5.0 (25)',
                    style: TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
