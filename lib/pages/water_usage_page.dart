import 'package:flutter/material.dart';
import 'common_layout.dart';

class WaterUsagePage extends StatelessWidget {
  const WaterUsagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('물 사용량 기록'),
        ),
        body: const Center(
          child: Text('물 사용량 기록 페이지'),
        ),
      ),
    );
  }
}
