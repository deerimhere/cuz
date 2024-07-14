import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
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
<<<<<<< HEAD
  bool isAnswering = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = "user-id"; // 실제 유저 ID를 여기에 설정
=======
  bool isAnswering = false; // 추가
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)

  @override
  void initState() {
    super.initState();
    _selectRandomQuestions();
<<<<<<< HEAD
    _checkFirstVisit();
  }

  Future<void> _checkFirstVisit() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();
    if (!snapshot.exists ||
        !(snapshot.data() as Map<String, dynamic>)['isFirstQuizVisit']) {
      _showIntroDialog();
      await _firestore.collection('users').doc(userId).set({
        'isFirstQuizVisit': false,
      }, SetOptions(merge: true));
    }
  }

  void _showIntroDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('퀴즈 페이지 안내'),
          content: const Text('물 절약을 위해 문제를 풀고 포인트를 받아가세요!'),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
  }

  void _selectRandomQuestions() {
    Random random = Random();
    while (selectedQuestions.length < 5) {
      int questionIndex = random.nextInt(quizzes.length);
      if (!selectedQuestions.contains(questionIndex)) {
        selectedQuestions.add(questionIndex);
      }
    }
    setState(() {
      currentQuestionIndex = 0;
    });
  }

<<<<<<< HEAD
  void _checkAnswer(String answer) async {
    if (isAnswering) return;
=======
  void _checkAnswer(String answer) {
    if (isAnswering) return; // 추가: 중복 터치 방지
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)

    setState(() {
      isAnswering = true; // 추가: 터치 시작
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

    await Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        showAnimation = false;
        isAnswering = false; // 추가: 터치 종료
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              setState(() {
                showResult = false;
              });
              Navigator.of(context).pushReplacementNamed('/'); // 홈으로 이동
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
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
                  if (quizzes.isNotEmpty && currentQuestionIndex < quizzes.length)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        quizzes[selectedQuestions[currentQuestionIndex]][1],
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (quizzes.isNotEmpty && currentQuestionIndex < quizzes.length)
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
