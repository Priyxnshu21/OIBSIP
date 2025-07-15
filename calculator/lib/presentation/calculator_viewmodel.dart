import 'package:flutter/material.dart';
import 'package:calculator_app/core/calculator_service.dart'; // Import our core logic

class CalculatorViewModel extends ChangeNotifier {
  final CalculatorService _calculatorService; // Dependency injection

  String _input = '0'; // The string shown on the display (input/current result)
  String _history = ''; // Stores the operation history (e.g., "10 + 5")
  bool _hasCalculated = false; // Flag to reset input after an equals operation

  CalculatorViewModel(this._calculatorService);

  String get input => _input;
  String get history => _history;

  /// Handles a button press event.
  void onButtonPressed(String buttonText) {
    if (_hasCalculated &&
        !_isOperator(buttonText) &&
        buttonText != '.' &&
        buttonText != '+/-' &&
        buttonText != '%') {
      // If a calculation just finished and a number/decimal is pressed, start new calculation
      _input = buttonText;
      _history = ''; // Clear history for new calculation
      _hasCalculated = false;
    } else if (_hasCalculated && _isOperator(buttonText)) {
      // If a calculation just finished and an operator is pressed, continue with result
      _history = _input + buttonText;
      _input = '0'; // Prepare for next number input
      _hasCalculated = false;
    } else {
      switch (buttonText) {
        case 'AC':
          _input = '0';
          _history = '';
          _hasCalculated = false;
          break;
        case '+/-':
          _toggleSign();
          break;
        case '%':
          _applyPercentage();
          break;
        case '=':
          _calculateResult();
          break;
        case '.':
          _addDecimalPoint();
          break;
        case '÷':
        case '×':
        case '-':
        case '+':
          _addOperator(buttonText);
          break;
        default: // Number buttons
          _addNumber(buttonText);
          break;
      }
    }
    notifyListeners(); // Notify UI to rebuild
  }

  void _addNumber(String number) {
    if (_input == '0' && number != '.') {
      _input = number;
    } else {
      _input += number;
    }
  }

  void _addDecimalPoint() {
    // Only add if not already present in the current number segment
    final lastOperatorIndex = _getLastOperatorIndex(_input);
    final currentNumberSegment = lastOperatorIndex == -1
        ? _input
        : _input.substring(lastOperatorIndex + 1);

    if (!currentNumberSegment.contains('.')) {
      if (currentNumberSegment.isEmpty &&
          _input.isNotEmpty &&
          _isOperator(_input[_input.length - 1])) {
        // If operator is last, start new number with 0.
        _input += '0.';
      } else if (currentNumberSegment.isEmpty || _input.isEmpty) {
        // If input is empty or current segment is empty (e.g., after operator), start with "0."
        _input = '0.';
      } else {
        _input += '.';
      }
    }
  }

  void _addOperator(String operator) {
    if (_input.isEmpty || _input == 'Error') {
      // Don't add operator if display is empty or showing an error
      return;
    }

    // Replace last operator if consecutive operators are pressed
    if (_input.isNotEmpty && _isOperator(_input[_input.length - 1])) {
      _input = _input.substring(0, _input.length - 1) + operator;
    } else {
      _input += operator;
    }
  }

  void _toggleSign() {
    if (_input == '0' || _input.isEmpty || _input == 'Error') return;

    // Find the last number to toggle its sign
    final RegExp numberPattern = RegExp(r'(-?\d+(\.\d*)?)');
    final matches = numberPattern.allMatches(_input);

    if (matches.isNotEmpty) {
      final lastMatch = matches.last;
      final numberString = lastMatch.group(0)!;
      final startIndex = lastMatch.start;
      final endIndex = lastMatch.end;

      try {
        double number = double.parse(numberString);
        number *= -1;
        _input =
            _input.substring(0, startIndex) +
            number.toString() +
            _input.substring(endIndex);

        // Remove trailing .0 if it results from toggle
        if (_input.endsWith('.0')) {
          _input = _input.substring(0, _input.length - 2);
        }
      } catch (e) {
        // Handle potential parsing errors if current segment isn't a valid number
        _input = 'Error';
        _history = 'Invalid input for sign toggle';
      }
    } else {
      // If no valid number found, just return or show error
      _input = 'Error';
      _history = 'Invalid input for sign toggle';
    }
  }

  void _applyPercentage() {
    if (_input.isEmpty || _input == '0' || _input == 'Error') return;

    try {
      // Extract the last number to apply percentage to
      final RegExp numberPattern = RegExp(
        r'(\d+(\.\d*)?)$',
      ); // Matches number at end
      final match = numberPattern.firstMatch(_input);

      if (match != null) {
        final numberString = match.group(0)!;
        final double number = double.parse(numberString);
        final double percentageValue = number / 100.0;

        _input = _input.substring(0, match.start) + percentageValue.toString();
        // Clean up trailing .0 if present
        if (_input.endsWith('.0')) {
          _input = _input.substring(0, _input.length - 2);
        }
      } else {
        _input = 'Error';
        _history = 'Invalid input for percentage';
      }
    } catch (e) {
      _input = 'Error';
      _history = 'Invalid input for percentage';
    }
  }

  void _calculateResult() {
    try {
      // Store current input as history before calculation
      _history = _input;
      _input = _calculatorService.evaluateExpression(_input);
      _hasCalculated = true; // Set flag after successful calculation
    } on FormatException catch (e) {
      _input = 'Error';
      _history = e.message;
    } on ArithmeticException catch (e) {
      _input = 'Error';
      _history = e.message;
    } on Exception catch (e) {
      _input = 'Error';
      _history = 'An unknown error occurred: ${e.toString()}';
    }
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷';
  }

  int _getLastOperatorIndex(String text) {
    int lastIndex = -1;
    for (int i = text.length - 1; i >= 0; i--) {
      if (_isOperator(text[i])) {
        lastIndex = i;
        break;
      }
    }
    return lastIndex;
  }
}
