import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/user_model.dart';
import 'package:pumpit/model/wallet_model.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController(text: '+60');
  final String malaysiaPhoneNumberRegex = r'^\+60\d{1,3}-?\d{7,9}$';
  bool _isValidPhoneNumber = true;

  Future<bool> loginUser(String phone) async {
    Map<String, dynamic>? user =
        await DatabaseHelper.instance.getUserLogin(phone);
    if (user != null && user['phone'] == phone) {
      return true; // Login successful
    }
    return false; // Login failed
  }

  void _validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(malaysiaPhoneNumberRegex);
    bool isValid = regex.hasMatch(phoneNumber);
    setState(() {
      _isValidPhoneNumber = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    txtField(
                      controller: _nameController,
                      hintText: 'Name',
                      icon: PhosphorIcons.user,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    txtField(
                      controller: _phoneController,
                      hintText: '+60123456789',
                      icon: PhosphorIcons.phone,
                      keyboardType: TextInputType.phone,
                      errorText:
                          _isValidPhoneNumber ? null : 'Invalid phone number',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _validatePhoneNumber(value);
                      },
                    ),
                    signInBtn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget txtField({
    TextEditingController? controller,
    String? hintText,
    IconData? icon,
    bool? obscureText,
    String? errorText,
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
          errorText: errorText,
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
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          bool isLoggedIn = await loginUser(_phoneController.text);
          if (isLoggedIn) {
            Get.snackbar(
              'Error',
              'Phone number is already existed',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              borderRadius: 8,
              margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.23.h),
              duration: const Duration(seconds: 3),
            );
          } else {
            final newUser = User(
              id: Random().nextInt(100000) + 1,
              name: _nameController.text,
              phone: _phoneController.text,
            );

            await DatabaseHelper.instance.add(newUser).then((value) async {
              final userId = newUser.id;
              await DatabaseHelper.instance
                  .addWallet(
                    Wallet(userid: userId, amount: 0.00),
                  )
                  .then((value) => Get.back());
            });
          }
        }
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(vertical: 1.85.h, horizontal: 4.2.w),
        padding: EdgeInsets.all(4.2.w),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }
}
