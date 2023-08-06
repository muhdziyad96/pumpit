import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticateWithBiometrics = false;
  bool canAuthenticate = false;
  bool englishLang = true;
  bool malayLang = false;
  HomeController h = Get.find();

  @override
  void initState() {
    super.initState();
    checkBiometrics();
  }

  checkBiometrics() async {
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    setState(() {
      canAuthenticate = canAuthenticateWithBiometrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pump It',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              txtField(
                controller: _phoneController,
                hintText: 'Phone Number',
                icon: PhosphorIcons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
              ),
              signInBtn(),
              noAccount(),
              socialIcon(),
              languageSelection(),
              touchIdLogin(),
            ],
          ),
        ),
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
      margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.23.h),
      padding: EdgeInsets.only(left: 4.2.w),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
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

  Widget signInBtn() {
    return InkWell(
      onTap: isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                // Preference.setBool(Preference.isLogin, true);
                Get.offNamed('/home')?.then((value) {
                  h.changeTabIndex(0);
                });
              }
            },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(vertical: 1.85.h, horizontal: 4.2.w),
        padding: EdgeInsets.all(4.2.w),
        decoration: BoxDecoration(
          color: isLoading ? greyLess : primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            isLoading ? 'Loading' : 'Sign In',
            style: const TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget socialIcon() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PhosphorIcons.instagramLogoBold,
              color: defaultColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PhosphorIcons.facebookLogoBold,
              color: defaultColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PhosphorIcons.twitterLogoBold,
              color: defaultColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget languageSelection() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return languageDialog();
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(4.2.w),
        child: Column(
          children: [
            const Text('Language'),
            SizedBox(
              height: 1.2.h,
            ),
            const Icon(Icons.language),
          ],
        ),
      ),
    );
  }

  Widget languageDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6.4.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(color: whiteColor),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: whiteColor),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            title: const Text('English'),
            activeColor: primaryColor,
            value: englishLang,
            onChanged: (newValue) {
              setState(() {
                englishLang = true;
                malayLang = false;
              });
              Navigator.pop(context);
            },
          ),
          CheckboxListTile(
            title: const Text('Bahasa Malaysia'),
            activeColor: primaryColor,
            value: malayLang,
            onChanged: (newValue) {
              setState(() {
                malayLang = true;
                englishLang = false;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget touchIdLogin() {
    return InkWell(
      onTap: () async {
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (didAuthenticate) {
            Future.delayed(const Duration(seconds: 2), () {
              // Preference.setBool(Preference.isLogin, true);
              Get.offNamed('/home')?.then((value) {
                h.changeTabIndex(0);
              });
            });
          }
        } on PlatformException {
          // ...
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.fingerprint,
            size: 30,
            color: primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.1.w),
            child: const Text('Login with Touch ID'),
          ),
        ],
      ),
    );
  }

  Widget noAccount() {
    return Padding(
      padding: EdgeInsets.all(2.1.w),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: 'Dont have an account ? ',
            ),
            TextSpan(
                text: 'Sign Up !',
                style: const TextStyle(
                    color: Color.fromARGB(255, 34, 84, 171),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = () {})
          ],
        ),
      ),
    );
  }
}
