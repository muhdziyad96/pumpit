import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/util/preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = Preference.getBool(Preference.isLogin)!;
  bool showOnboard = Preference.getBool(Preference.showOnboard)!;
  String? version;
  String? backendVersion;

  redirectPage(int duration) {
    Timer(Duration(seconds: duration), () {
      showOnboard ? Get.offNamed('/welcome') : Get.offNamed('/login');
    });
  }

  onLoading() async {
    redirectPage(2);
  }

  @override
  void initState() {
    super.initState();
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Put image here
            Padding(
              padding: EdgeInsets.all(30.0),
              child: LinearProgressIndicator(
                color: primaryColor,
                backgroundColor: whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
