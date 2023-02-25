import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.validation,
    this.hintText,
    this.obscureText = false,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validation,
      controller: controller,
      style: $styles.text.styleInter.copyWith(
        color: $styles.colors.color2573E9,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: $styles.text.styleInter.copyWith(
          color: $styles.colors.color666E7A,
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: $styles.colors.color0F8FEC,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: $styles.colors.color0F8FEC,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: $styles.colors.color0F8FEC,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
