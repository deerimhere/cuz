import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
<<<<<<< HEAD
import 'package:intl/intl.dart'; // 날짜 형식 사용
import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
import '../score_manager.dart';
import 'common_layout.dart';

class WaterUsagePage extends StatefulWidget {
  const WaterUsagePage({Key? key}) : super(key: key);

  @override
  _WaterUsagePageState createState() => _WaterUsagePageState();
}

class _WaterUsagePageState extends State<WaterUsagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _waterUsageController = TextEditingController();
  int _members = 1; // 기본값
  double _dailyWaterLimit = 198; // 하루 기준 물 사용량(L)
<<<<<<< HEAD
  String? _lastRecordedDate; // 마지막 기록된 날짜
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userId = "user-id"; // 실제 유저 ID를 여기에 설정
=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_userId).get();
    setState(() {
      _members = snapshot['members'] ?? 1;
      _membersController.text = _members.toString();
    });
  }

<<<<<<< HEAD
  Future<void> _loadLastRecordedDate() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_userId).get();
    setState(() {
      _lastRecordedDate = snapshot['lastRecordedDate'];
    });
  }

=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
  Future<void> _saveMembers() async {
    if (_formKey.currentState!.validate()) {
      await _firestore.collection('users').doc(_userId).set({
        'members': int.parse(_membersController.text),
      }, SetOptions(merge: true));
      setState(() {
        _members = int.parse(_membersController.text);
      });
    }
  }

  Future<void> _saveWaterUsage() async {
    if (_formKey.currentState!.validate()) {
<<<<<<< HEAD
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (_lastRecordedDate == today) {
        _showDialogWithMessage('오늘은 이미 물 사용량을 기록했습니다.');
        return;
      }

=======
      SharedPreferences prefs = await SharedPreferences.getInstance();
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
      double waterUsage = double.parse(_waterUsageController.text);
      double perPersonUsage = waterUsage / _members;

      String message;
      int points;

      if (perPersonUsage < _dailyWaterLimit) {
        message =
            '와우 당신은 절약왕! 인당 물 사용량: ${perPersonUsage.toStringAsFixed(2)}L, 포인트 +30';
        points = 30;
      } else {
        message =
            '좀 더 노력하세요! 인당 물 사용량: ${perPersonUsage.toStringAsFixed(2)}L, 포인트 +10';
        points = 10;
      }

<<<<<<< HEAD
      await _firestore.collection('users').doc(_userId).set({
        'lastRecordedDate': today,
      }, SetOptions(merge: true));
=======
>>>>>>> parent of 611a8ca (UI바꾸기 전 최종수정)
      Provider.of<ScoreManager>(context, listen: false).addPoints(points);
      _showDialogWithAnimation(message);
    }
  }

  void _showDialogWithAnimation(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animation_check.json',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('물 사용량 기록'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '가정 내 인원 수 입력',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _membersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '가정 내 인원 수',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '가정 내 인원 수를 입력해주세요';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return '유효한 숫자를 입력해주세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveMembers,
                  child: const Text('저장'),
                ),
                const SizedBox(height: 20),
                const Text(
                  '오늘 사용한 물의 양 입력',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _waterUsageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '물 사용량 (L)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '물 사용량을 입력해주세요';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return '유효한 숫자를 입력해주세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveWaterUsage,
                  child: const Text('저장'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
