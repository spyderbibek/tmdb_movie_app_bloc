/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors();
  static const Color mainColor = const Color(0xFF151C26);
  static const Color thirdColor = const Color(0xFF1A2330);
  static const Color secondColor = const Color(0xFFF4C10F);
  static const Color titleColor = const Color(0xFF5A606B);
}

class TextTheme {
  const TextTheme();
  static const TextStyle headline =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24);

  static const TextStyle body1 =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18);

  static const TextStyle body2 =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16);

  static const TextStyle caption = TextStyle(
      fontWeight: FontWeight.normal, color: Colors.white, fontSize: 14);
}
