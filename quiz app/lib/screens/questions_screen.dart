import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showFeedback = false;

  void answerQuestion(String answer) async {
    if (selectedAnswer != null) return;
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    widget.onSelectAnswer(answer);
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final correctAnswer = currentQuestion.answers[0];
    final progress = (currentQuestionIndex + 1) / questions.length;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Column(
            key: ValueKey(currentQuestionIndex),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.lightBlueAccent),
                  minHeight: 8,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                currentQuestion.text,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ...currentQuestion.getShuffledAnswers().map((answer) {
                Color? buttonColor;
                if (selectedAnswer != null) {
                  if (answer == selectedAnswer) {
                    buttonColor =
                        answer == correctAnswer ? Colors.green : Colors.red;
                  } else if (answer == correctAnswer) {
                    buttonColor = Colors.green;
                  }
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: AnswerButton(
                    key: ValueKey('$currentQuestionIndex-$answer-$buttonColor'),
                    text: answer,
                    onTap: selectedAnswer == null
                        ? () => answerQuestion(answer)
                        : null,
                    color: buttonColor,
                  ),
                );
              }),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: selectedAnswer != null
                    ? Padding(
                        key: ValueKey('feedback-$currentQuestionIndex'),
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          selectedAnswer == correctAnswer
                              ? 'Correct!'
                              : 'Oops, wrong answer!',
                          style: TextStyle(
                            color: selectedAnswer == correctAnswer
                                ? Colors.green
                                : Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
