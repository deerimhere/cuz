import 'package:flutter/material.dart';
import 'common_layout.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('회원가입'),
        ),
        body: const Center(
          child: Text('회원가입 페이지'),
        ),
      ),
    );
  }
}
