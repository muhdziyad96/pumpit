import 'package:get/get.dart';
import 'package:pumpit/routes/app_routes.dart';
import 'package:pumpit/screen/auth/login_screen.dart';
import 'package:pumpit/screen/auth/sign_up_screen.dart';
import 'package:pumpit/screen/home/home_screen.dart';
import 'package:pumpit/screen/map/map_screen.dart';
import 'package:pumpit/screen/setting/payment_card/payment_card_screen.dart';
import 'package:pumpit/screen/splash_screen.dart';
import 'package:pumpit/screen/welcome_screen.dart';

class AppPages {
  static const home = AppRoutes.home;
  static const splashScreen = AppRoutes.splashScreen;

  static final pageList = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentCard,
      page: () => const PaymentCardScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => const ProfileScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.chart,
    //   page: () => const ChartScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.setting,
    //   page: () => const SettingScreen(),
    // ),
    GetPage(
      name: AppRoutes.map,
      page: () => const MapScreen(),
    ),
  ];
}
