import 'package:flutter/material.dart';
import 'common_layout.dart';

class GardenPage extends StatelessWidget {
  const GardenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('가상 정원'),
        ),
        body: const Center(
          child: Text('가상 정원 페이지'),
        ),
      ),
    );
  }
}
