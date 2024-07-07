import 'package:flutter/material.dart';
import 'common_layout.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
        ),
        body: Center(
          child: Text('로그인 페이지'),
        ),
      ),
    );
  }
}
