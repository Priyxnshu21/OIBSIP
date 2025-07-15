import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  String evaluateExpression(String expression) {
    if (expression.isEmpty) {
      return '0';
    }

    try {
      String parsedExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      GrammarParser p = GrammarParser();
      Expression exp = p.parse(parsedExpression);
      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      if (result.isInfinite) {
        throw ArithmeticException('Division by zero is not allowed.');
      }
      if (result.isNaN) {
        throw FormatException('Invalid expression or result.');
      }

      if (result == result.toInt()) {
        return result.toInt().toString();
      } else {
        return result.toString();
      }
    } on FormatException catch (e) {
      throw FormatException('Invalid expression: ${e.message}');
    } on Exception catch (e) {
      throw Exception('Calculation error: ${e.toString()}');
    }
  }
}

class ArithmeticException implements Exception {
  final String message;
  ArithmeticException(this.message);

  @override
  String toString() => 'ArithmeticException: $message';
}
