import 'package:flutter/material.dart';
import 'common_layout.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('리워드'),
        ),
        body: const Center(
          child: Text('리워드 페이지'),
        ),
      ),
    );
  }
}
