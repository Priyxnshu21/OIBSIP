import 'package:flutter/material.dart';
import 'package:calculator_app/presentation/utils/app_dimens.dart';
import 'package:calculator_app/presentation/utils/app_styles.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final double width; // Allows for wider buttons like '0'
  final double height;
  final double cornerRadius;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    this.width = AppDimens.buttonSize,
    this.height = AppDimens.buttonSize,
    this.cornerRadius = AppDimens.buttonCornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding ensures space between buttons even without a direct Row/Column space
      margin: const EdgeInsets.all(AppDimens.buttonSpacing / 2),
      width: width,
      height: height,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(cornerRadius),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: AppStyles.buttonTextStyle.copyWith(color: foregroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
