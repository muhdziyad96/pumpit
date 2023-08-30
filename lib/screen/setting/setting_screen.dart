import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/util/preference.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingBtn(
                  title: 'Add Payment Card',
                  onTap: () {
                    Get.toNamed('/paymentCard');
                  }),
              settingBtn(title: 'Help Centre', onTap: () {}),
              settingBtn(title: 'Legal', onTap: () {}),
              settingBtn(title: 'Change Language', onTap: () {}),
              settingBtn(
                  title: 'Logout',
                  onTap: () {
                    Get.offNamed('/login');
                    Preference.setBool(Preference.isLogin, false);
                    Preference.remove(Preference.userId);
                  }),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
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
      ),
    );
  }

  Widget settingBtn({required String title, required void Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(3.5.w),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
