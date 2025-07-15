import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_app/presentation/calculator_viewmodel.dart';
import 'package:calculator_app/presentation/widgets/calculator_button.dart';
import 'package:calculator_app/presentation/utils/app_colors.dart';
import 'package:calculator_app/presentation/utils/app_styles.dart';
import 'package:calculator_app/presentation/utils/app_dimens.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CalculatorViewModel>();

    final List<List<String>> buttonLayout = [
      ['AC', '+/-', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: AppDimens.displayMinHeight,
                  ),
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(AppDimens.buttonSpacing),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (viewModel.history.isNotEmpty)
                        Flexible(
                          child: Text(
                            viewModel.history,
                            style: AppStyles.displayTextStyle.copyWith(
                              fontSize: 30.0,
                              color: AppColors.displayText.withAlpha(
                                (0.7 * 255).toInt(),
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      Flexible(
                        child: Text(
                          viewModel.input,
                          style: AppStyles.displayTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: buttonLayout.map((rowButtons) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: rowButtons.map((buttonText) {
                      Color bgColor;
                      Color fgColor;
                      double buttonWidth = AppDimens.buttonSize;
                      double cornerRadius = AppDimens.buttonCornerRadius;

                      if (buttonText == '0') {
                        bgColor = AppColors.numberButtonBackground;
                        fgColor = AppColors.numberButtonForeground;
                        buttonWidth =
                            (AppDimens.buttonSize * 2) +
                            AppDimens.buttonSpacing;
                      } else if ([
                        '÷',
                        '×',
                        '-',
                        '+',
                        '=',
                      ].contains(buttonText)) {
                        bgColor = AppColors.operatorButtonBackground;
                        fgColor = AppColors.operatorButtonForeground;
                      } else if (['AC', '+/-', '%'].contains(buttonText)) {
                        bgColor = AppColors.specialButtonBackground;
                        fgColor = AppColors.specialButtonForeground;
                      } else {
                        bgColor = AppColors.numberButtonBackground;
                        fgColor = AppColors.numberButtonForeground;
                      }

                      if (buttonText == '0') {
                        cornerRadius = AppDimens.buttonSize / 2;
                      }

                      return CalculatorButton(
                        text: buttonText,
                        backgroundColor: bgColor,
                        foregroundColor: fgColor,
                        onPressed: () => viewModel.onButtonPressed(buttonText),
                        width: buttonWidth,
                        height: AppDimens.buttonSize,
                        cornerRadius: cornerRadius,
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
