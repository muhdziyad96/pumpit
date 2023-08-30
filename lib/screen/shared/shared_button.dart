import 'package:flutter/material.dart';
import 'package:pumpit/constant/color.dart';
import 'package:sizer/sizer.dart';

class SharedButton extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  const SharedButton({super.key, required this.title, this.onTap});

  @override
  State<SharedButton> createState() => _SharedButtonState();
}

class _SharedButtonState extends State<SharedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.1.w, horizontal: 4.2.w),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(3.5.w),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
