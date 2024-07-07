import 'package:flutter/material.dart';
import 'common_layout.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('커뮤니티'),
        ),
        body: const Center(
          child: Text('커뮤니티 페이지'),
        ),
      ),
    );
  }
}
