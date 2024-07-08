import 'package:flutter/material.dart';
import 'common_layout.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('홈'),
        ),
        body: Center(
          child: Text(
            '환영합니다!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
