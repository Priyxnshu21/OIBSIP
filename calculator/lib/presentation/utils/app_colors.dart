import 'package:flutter/material.dart';

class AppColors {
  // Calculator background
  static const Color background = Colors.black;

  // Display text color
  static const Color displayText = Colors.white;

  // Number/Zero buttons
  static const Color numberButtonBackground = Color(0xFF333333); // Dark Gray
  static const Color numberButtonForeground = Colors.white;

  // Operator buttons (+, -, ×, ÷, =)
  static const Color operatorButtonBackground = Color(0xFFFF9500); // Orange
  static const Color operatorButtonForeground = Colors.white;

  // Special function buttons (AC, +/-, %)
  static const Color specialButtonBackground = Color(0xFFA5A5A5); // Light Gray
  static const Color specialButtonForeground = Colors.black;

  // Clear button (AC) specific color if needed, otherwise uses specialButtonBackground
  // static const Color clearButtonBackground = Color(0xFFA5A5A5);
  // static const Color clearButtonForeground = Colors.black;
}
