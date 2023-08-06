import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/constant/color.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.all(4.2.w),
            child: const Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(
                  PhosphorIcons.cat,
                  size: 36,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Change profile picture',
                  style: TextStyle(fontSize: 14, color: primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Name: Muhammad Ziyad',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
          ),
          Divider(
            indent: 4.2.w,
            endIndent: 4.2.w,
            color: greyLess,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'ID Number: 37893718',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
          ),
          Divider(
            indent: 4.2.w,
            endIndent: 4.2.w,
            color: greyLess,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Phone Number: +60 123456789',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
          ),
          Divider(
            indent: 4.2.w,
            endIndent: 4.2.w,
            color: greyLess,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Email: muhdziyad96@hotmail.com',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
          ),
          Divider(
            indent: 4.2.w,
            endIndent: 4.2.w,
            color: greyLess,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Gender: Male',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2.1.w),
                child: const Text(
                  'Update profile',
                  style: TextStyle(fontSize: 14, color: primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
