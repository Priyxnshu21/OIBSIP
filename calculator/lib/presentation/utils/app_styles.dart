import 'package:flutter/material.dart';
import 'package:calculator_app/presentation/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // Display text style (for input and result)
  static TextStyle displayTextStyle = GoogleFonts.roboto(
    // You can choose any Google Font here, e.g., GoogleFonts.openSans(), GoogleFonts.lato()
    color: AppColors.displayText,
    fontSize: 90.0, // Large font size for readability
    fontWeight: FontWeight.w300, // Light weight, common in iOS
  );

  // Button text style
  static TextStyle buttonTextStyle = GoogleFonts.roboto(
    // Matching font for buttons
    fontSize: 40.0, // Large font for buttons
    fontWeight: FontWeight.w400, // Regular weight
  );

  // Example of another style if needed
  static TextStyle operatorButtonTextStyle = GoogleFonts.roboto(
    fontSize: 40.0,
    fontWeight: FontWeight.w400,
    color: Colors.white, // Assuming operators might have white text
  );

  // Note: Using 'static TextStyle' instead of 'static const TextStyle'
  // when using GoogleFonts as the font loading might be asynchronous
  // or involves methods that aren't compile-time constants.
}
