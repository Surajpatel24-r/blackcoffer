import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/values/colors.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  String label = 'Lable';
  bool isValidate = false;
  bool readOnly = false;
  FormFieldValidator<String>? validator;
  void Function(String)? onChanged;
  void Function()? onTap;
  TextInputType? keyboardType;
  TextEditingController controller;
  int? maxLength;
  int? maxLines;
  AppTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.isValidate = false,
      this.onChanged,
      this.validator,
      this.keyboardType,
      this.readOnly = false,
      this.onTap,
      this.maxLength,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          focusColor: Colors.black,
          contentPadding: EdgeInsets.only(right: 40.w, left: 12.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelText: label,
          counterStyle: Theme.of(context).textTheme.bodyLarge,
          helperStyle: Theme.of(context).textTheme.bodyLarge,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          suffixIcon: isValidate
              ? const Icon(
                  Icons.check_circle_outline_outlined,
                  color: ColorConstant.indigo,
                )
              : null),
    );
  }
}
