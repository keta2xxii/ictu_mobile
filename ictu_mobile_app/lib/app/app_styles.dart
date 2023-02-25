import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final $styles = AppStyle();

class AppStyle {
  final AppColors colors = AppColors();
  final AppTextStyle text = AppTextStyle();
  final AppShadows shadows = AppShadows();
}

class AppShadows {
  final iconShadow = [
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 3.0,
      spreadRadius: 3.0,
      offset: Offset(0.0, 3.0),
    ),
  ];
}

class AppTextStyle {
  final TextStyle header = const TextStyle();

  final TextStyle styleInter = GoogleFonts.inter();
}
