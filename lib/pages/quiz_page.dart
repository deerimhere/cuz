import 'package:flutter/material.dart';
import 'common_layout.dart';
import '../score_manager.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<List<dynamic>> quizzes = [
    [1, "지구 표면의 70%가 물로 덮여 있다.", "O"],
    [2, "지구상의 물 중 담수의 대부분은 빙하와 만년설로 되어 있다.", "O"],
    [3, "우리가 사용할 수 있는 물은 지구 전체 물의 1%도 되지 않는다.", "O"],
    [4, "감자튀김 1인분을 만드는 데 필요한 물의 양은 50리터 이상이다.", "X"],
    [5, "사람 몸의 60%에서 85%가 물로 구성되어 있다.", "O"],
    [6, "물은 고체, 액체, 기체 상태로 존재할 수 있는 유일한 물질이다.", "O"],
    [7, "지구상의 민물 중 지하수의 비율은 10%가 넘는다.", "X"],
    [8, "물은 상온에서 기체 상태로만 존재한다.", "X"],
    [9, "햄버거 하나를 만드는 데 필요한 물의 양은 4,930리터이다.", "O"],
    [10, "지구상의 물이 사라지면 지구는 거대한 땅덩어리에 지나지 않을 것이다.", "O"],
    [11, "지구의 전체 물 중 97%는 염수이다.", "O"],
    [12, "담수는 지구상의 물의 3%를 차지한다.", "O"],
    [13, "담수의 대부분은 호수와 강에 있다.", "X"],
    [14, "지구상에서 가장 큰 담수호는 바이칼호이다.", "O"],
    [15, "대기 중의 수증기는 전 세계 물 순환의 중요한 부분이다.", "O"],
    [16, "물의 밀도는 4°C에서 가장 낮다.", "X"],
    [17, "빙하는 물보다 밀도가 높다.", "X"],
    [18, "물은 극성을 띠는 분자이다.", "O"],
    [19, "물 분자는 산소와 수소로 구성되어 있다.", "O"],
    [20, "수소 결합은 물의 높은 표면 장력을 설명한다.", "O"],
    [21, "지구상의 모든 물의 순환은 태양에 의해 구동된다.", "O"],
    [22, "한 사람이 하루에 필요한 물의 양은 평균 2~3리터이다.", "O"],
    [23, "지구상의 물은 고정된 양만큼만 존재한다.", "O"],
    [24, "해양은 지구 기후 조절에 중요한 역할을 한다.", "O"],
    [25, "강수량은 지역마다 매우 다르다.", "O"],
    [26, "물의 비열은 다른 대부분의 물질보다 낮다.", "X"],
    [27, "물은 거의 모든 물질을 어느 정도는 용해시킬 수 있다.", "O"],
    [28, "증발은 대기의 습도를 조절하는 중요한 과정이다.", "O"],
    [29, "물의 끓는점은 100°C이다.", "O"],
    [30, "물은 지구상의 생명 유지에 필수적이다.", "O"],
    [31, "지구상의 물은 항상 동일한 상태로 존재한다.", "X"],
    [32, "수증기는 온실가스의 하나이다.", "O"],
    [33, "물의 화학식은 H2O이다.", "O"],
    [34, "물의 표면 장력은 다른 액체보다 낮다.", "X"],
    [35, "지구상의 모든 생명체는 물을 필요로 한다.", "O"],
    [36, "물은 전기 전도성이 없는 물질이다.", "X"],
    [37, "지하수는 대수층에서 발견된다.", "O"],
    [38, "물은 무색, 무취, 무미의 액체이다.", "O"],
    [39, "물은 0°C에서 얼기 시작한다.", "O"],
    [40, "수소 결합은 물 분자 사이의 강한 인력을 형성한다.", "O"],
    [41, "물은 자연 상태에서 순수한 형태로 존재하지 않는다.", "O"],
    [42, "물의 분자 구조는 직선형이다.", "X"],
    [43, "물의 표면 장력은 많은 곤충이 물 위를 걸을 수 있게 한다.", "O"],
    [44, "물은 다른 물질과 화학적으로 반응하지 않는다.", "X"],
    [45, "대부분의 식물은 뿌리를 통해 물을 흡수한다.", "O"],
    [46, "물의 비열은 기후 조절에 중요한 역할을 한다.", "O"],
    [47, "물은 무기질이다.", "O"],
    [48, "수소 결합은 물 분자 간의 인력을 약하게 만든다.", "X"],
    [49, "지구상의 물의 대부분은 태평양에 있다.", "O"],
    [50, "해양은 지구의 온도를 조절하는 데 중요한 역할을 한다.", "O"],
    [51, "물의 끓는점은 해발 고도에 따라 변한다.", "O"],
    [52, "물은 고체 상태에서 액체 상태보다 부피가 작다.", "X"],
    [53, "대기 중의 수증기는 지구 온난화에 기여한다.", "O"],
    [54, "물은 음용수로서 생명 유지에 필수적이다.", "O"],
    [55, "지구상의 모든 물은 해수이다.", "X"],
    [56, "물의 화학식은 H2O2이다.", "X"],
    [57, "물은 거의 모든 생명체의 체내에서 중요한 역할을 한다.", "O"],
    [58, "수소 결합은 물의 높은 비열을 설명한다.", "O"],
    [59, "지구상의 물은 고정된 양만큼만 존재한다.", "O"],
    [60, "지구상의 모든 생명체는 물을 필요로 한다.", "O"],
    [61, "해양은 지구 생태계의 중요한 부분이다.", "O"],
    [62, "물은 상온에서 고체 상태로 존재한다.", "X"],
    [63, "물은 무색, 무취, 무미의 액체이다.", "O"],
    [64, "지구상의 물의 대부분은 염수이다.", "O"],
    [65, "지하수는 대수층에서 발견된다.", "O"],
    [66, "물은 전기 전도성이 없다.", "X"],
    [67, "증발은 대기의 습도를 조절하는 중요한 과정이다.", "O"],
    [68, "빙하는 지구 기후 조절에 중요한 역할을 한다.", "O"],
    [69, "물은 모든 형태의 생명에 필수적이다.", "O"],
    [70, "물은 대부분의 물질을 어느 정도는 용해시킬 수 있다.", "O"],
    [71, "지구상의 물은 항상 동일한 상태로 존재한다.", "X"],
    [72, "수소 결합은 물의 높은 표면 장력을 설명한다.", "O"],
    [73, "물은 거의 모든 물질을 어느 정도는 용해시킬 수 있다.", "O"],
    [74, "물이 얼 때 부피가 줄어든다.", "X"],
    [75, "물은 다른 대부분의 물질보다 밀도가 높다.", "X"],
    [76, "물은 열을 잘 전달하는 물질이다.", "O"],
    [77, "물의 끓는점은 해수면에서 100°C이다.", "O"],
    [78, "물은 모든 형태의 생명에 필요하지 않다.", "X"],
    [79, "지하수는 쉽게 오염될 수 없다.", "X"],
    [80, "물은 열을 전달하는 능력이 낮다.", "X"],
    [81, "물은 자연 상태에서 순수한 형태로 존재하지 않는다.", "O"],
    [82, "물의 분자 구조는 직선형이다.", "X"]
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int attempts = 0;
  bool showResult = false;
  bool showAnimation = false;
  bool isCorrect = false;

  void _checkAnswer(String userAnswer) {
    setState(() {
      if (quizzes[currentQuestionIndex][2] == userAnswer) {
        score += 10;
        isCorrect = true;
        ScoreManager.updateTotalPoints(10);
      } else {
        isCorrect = false;
      }
      showAnimation = true;
      attempts++;

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showAnimation = false;
          if (attempts >= 5) {
            showResult = true;
          } else {
            currentQuestionIndex++;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('물 절약 퀴즈'),
        ),
        body: showResult
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('퀴즈 완료!', style: TextStyle(fontSize: 24)),
                    Text('맞춘 개수: ${score / 10}',
                        style: TextStyle(fontSize: 20)),
                    Text('틀린 개수: ${5 - (score / 10)}',
                        style: TextStyle(fontSize: 20)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          score = 0;
                          attempts = 0;
                          currentQuestionIndex = 0;
                          showResult = false;
                        });
                      },
                      child: Text('다시 시작'),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      quizzes[currentQuestionIndex][1],
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (showAnimation)
                    Lottie.asset(
                      isCorrect
                          ? 'assets/animation_correct.json'
                          : 'assets/animation_wrong.json',
                      width: 150,
                      height: 150,
                    )
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _checkAnswer("O"),
                          child: Text('O'),
                        ),
                        ElevatedButton(
                          onPressed: () => _checkAnswer("X"),
                          child: Text('X'),
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
