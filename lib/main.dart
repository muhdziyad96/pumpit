import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/geolocator_controller.dart';
import 'package:pumpit/controller/home_controller.dart';
import 'package:pumpit/routes/app_pages.dart';
import 'package:pumpit/service/route_service.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => GeoLocatorController());
  HttpOverrides.global = MyHttpOverrides();
  await Preference.init();
  Preference.getString(Preference.defaultLogin) ??
      Preference.setString(Preference.defaultLogin, 'Not Set');
  Preference.getBool(Preference.showOnboard) ??
      Preference.setBool(Preference.showOnboard, true);
  Preference.getBool(Preference.isLogin) ??
      Preference.setBool(Preference.isLogin, false);
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteServices.generateRoute,
        title: 'Pump It',
        builder: (context, child) {
          return SafeArea(
            minimum: EdgeInsets.only(top: 5.h),
            child: Scaffold(
              body: child,
            ),
          );
        },
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.deepPurple[100],
          primaryColor: primaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins.toString(),
        ),

        // initialRoute: '/splashScreen',
        initialRoute: '/splashScreen',
        getPages: AppPages.pageList,
      );
    });
  }
}
