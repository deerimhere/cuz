import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../score_manager.dart';
import 'common_layout.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<Map<String, dynamic>> items = [
    {'icon': Icons.star, 'name': 'Item 1', 'price': 100},
    {'icon': Icons.star_border, 'name': 'Item 2', 'price': 300},
    {'icon': Icons.stars, 'name': 'Item 3', 'price': 500},
    {'icon': Icons.local_activity, 'name': 'Item 4', 'price': 1000},
    {'icon': Icons.local_offer, 'name': 'Item 5', 'price': 1500},
  ];

  Future<void> _purchaseItem(int price, String itemName) async {
    final scoreManager = Provider.of<ScoreManager>(context, listen: false);
    if (scoreManager.totalPoints >= price) {
      scoreManager.subtractPoints(price);
      _showPurchaseSuccessDialog(itemName);
    } else {
      _showInsufficientPointsDialog();
    }
  }

  void _showInsufficientPointsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("포인트 부족"),
        content: Text("포인트가 부족합니다."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  void _showPurchaseSuccessDialog(String itemName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("구매 완료"),
        content: Text("$itemName을(를) 구매했습니다."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('포인트 및 리워드'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(items[index]['icon']),
                title: Text(items[index]['name']),
                trailing: Text('${items[index]['price']} 포인트'),
                onTap: () =>
                    _purchaseItem(items[index]['price'], items[index]['name']),
              ),
            );
          },
        ),
      ),
    );
  }
}
