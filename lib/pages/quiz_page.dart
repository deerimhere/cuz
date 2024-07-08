import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../score_manager.dart';
import 'common_layout.dart';
import '../data/quiz_data.dart'; // 추가
import 'dart:math';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> answeredQuestions = [];
  List<int> selectedQuestions = [];
  int currentQuestionIndex = 0;
  bool showAnimation = false;
  bool isCorrect = false;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    _selectRandomQuestions();
  }

  void _selectRandomQuestions() {
    Random random = new Random();
    while (selectedQuestions.length < 5) {
      int questionIndex = random.nextInt(quizzes.length);
      if (!selectedQuestions.contains(questionIndex)) {
        selectedQuestions.add(questionIndex);
      }
    }
  }

  void _checkAnswer(String answer) {
    setState(() {
      bool isAnswerCorrect =
          quizzes[selectedQuestions[currentQuestionIndex]][2] == answer;
      showAnimation = true;
      isCorrect = isAnswerCorrect;
      if (isAnswerCorrect) {
        correctAnswers++;
        Provider.of<ScoreManager>(context, listen: false).addPoints(10);
      } else {
        wrongAnswers++;
      }
      answeredQuestions.add(selectedQuestions[currentQuestionIndex]);
    });

    Future.delayed(Duration(milliseconds: 1250), () {
      setState(() {
        showAnimation = false;
        if (answeredQuestions.length < 5) {
          currentQuestionIndex++;
        } else {
          _showResultDialog();
        }
      });
    });
  }

  void _showResultDialog() {
    setState(() {
      showResult = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 밖을 터치해도 닫히지 않도록 설정
      builder: (context) => AlertDialog(
        title: Text("퀴즈 결과", textAlign: TextAlign.center),
        content: Text("맞은 문제: $correctAnswers\n틀린 문제: $wrongAnswers",
            textAlign: TextAlign.center),
      ),
    );

    // 일정 시간 후 자동으로 홈으로 이동
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showResult = false;
      });
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('물 절약 퀴즈'),
        ),
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: showAnimation || showResult,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      quizzes[selectedQuestions[currentQuestionIndex]][1],
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _checkAnswer("O"),
                        child: Text("O"),
                      ),
                      ElevatedButton(
                        onPressed: () => _checkAnswer("X"),
                        child: Text("X"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showAnimation)
              Center(
                child: Lottie.asset(
                  isCorrect
                      ? 'assets/animation_correct.json'
                      : 'assets/animation_wrong.json',
                  width: isCorrect ? 200 : 100, // 조건에 따라 크기 변경
                  height: isCorrect ? 200 : 100, // 조건에 따라 크기 변경
                  animate: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
