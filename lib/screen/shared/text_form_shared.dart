import 'package:flutter/material.dart';
import 'package:pumpit/constant/color.dart';
import 'package:sizer/sizer.dart';

class SharedTextFormWithContainer extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const SharedTextFormWithContainer(
      {super.key,
      this.controller,
      this.hintText,
      this.icon,
      this.obscureText,
      this.keyboardType,
      this.onTap,
      this.onChanged,
      this.validator});

  @override
  State<SharedTextFormWithContainer> createState() =>
      _SharedTextFormWithContainerState();
}

class _SharedTextFormWithContainerState
    extends State<SharedTextFormWithContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.2.w),
      child: TextFormField(
        onChanged: widget.onChanged ?? (String value) {},
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          suffixIcon: InkWell(
            onTap: widget.onTap ?? () {},
            child: Icon(
              widget.icon,
              color: primaryColor,
            ),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}

class SharedTextFormNoContainer extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final String? errorText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  const SharedTextFormNoContainer(
      {super.key,
      required this.title,
      this.controller,
      this.hintText,
      this.icon,
      this.errorText,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.maxLength});

  @override
  State<SharedTextFormNoContainer> createState() =>
      _SharedTextFormNoContainerState();
}

class _SharedTextFormNoContainerState extends State<SharedTextFormNoContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.2.w),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          label: Text(widget.title),
          errorText: widget.errorText,
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.2.w),
          hintText: widget.hintText,
          suffixIcon: InkWell(
            child: Icon(
              widget.icon,
              color: primaryColor,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16, color: primaryColor),
        validator: widget.validator,
      ),
    );
  }
}
