import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatefulWidget {
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
  CustomTextFormField({
    super.key,
    this.colorBorderSide = AppColors.greyColor,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.controller,
    this.keyBoardType = TextInputType.text,
    this.obsecureText = false
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: buildDecorationBorder(
          colorBorderSide: widget.colorBorderSide,
        ),
        focusedBorder: buildDecorationBorder(
          colorBorderSide: widget.colorBorderSide,
        ),
        errorBorder: buildDecorationBorder(
          colorBorderSide: AppColors.redColor,
        ),
        focusedErrorBorder: buildDecorationBorder(
          colorBorderSide: AppColors.redColor,
        ),
        errorStyle: AppStyles.medium16Praimary.copyWith( color: AppColors.redColor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppStyles.medium16Gray,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? AppStyles.medium16Gray,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obsecureText,
    );
  }

  OutlineInputBorder buildDecorationBorder({required colorBorderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorderSide, width: 1),
    );
  }
}
