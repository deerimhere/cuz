import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../score_manager.dart';
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
          child: FutureBuilder<int>(
            future: Provider.of<ScoreManager>(context, listen: false)
                .getTotalPoints(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('총 포인트: ${snapshot.data}');
              }
            },
          ),
        ),
      ),
    );
  }
}
