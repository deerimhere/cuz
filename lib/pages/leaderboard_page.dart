import 'package:flutter/material.dart';
import 'common_layout.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('리더보드'),
        ),
        body: const Center(
          child: Text('리더보드 페이지'),
        ),
      ),
    );
  }
}
