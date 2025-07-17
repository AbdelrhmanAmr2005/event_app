import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color colorBorderSide;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator validator;
  TextEditingController controller;
  TextInputType keyBoardType;
  bool obsecureText;
  int? maxLines;

  CustomTextFormField({
    super.key,
    required this.colorBorderSide,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines,
    required this.controller,
    this.keyBoardType = TextInputType.text,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: buildDecorationBorder(
          colorBorderSide: colorBorderSide,
        ),
        focusedBorder: buildDecorationBorder(
          colorBorderSide: colorBorderSide,
        ),
        errorBorder: buildDecorationBorder(colorBorderSide: AppColors.redColor),
        focusedErrorBorder: buildDecorationBorder(
          colorBorderSide: AppColors.redColor,
        ),
        errorStyle: AppStyles.medium16Praimary.copyWith(
          color: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.medium16Gray,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.medium16Gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      controller: controller,
      keyboardType: keyBoardType,
      obscureText: obsecureText,
    );
  }

  OutlineInputBorder buildDecorationBorder({required colorBorderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorderSide, width: 1),
    );
  }
}
