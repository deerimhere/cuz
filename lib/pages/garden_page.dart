import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../models/tree_model.dart';
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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Consumer2<TreeManager, ItemData>(
                  builder: (context, treeManager, itemData, child) {
                    final evolveItem = itemData.items.firstWhere((item) => item.name == '진화!');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (treeManager.tree.level == 0)
                          Text(
                            '씨앗을 심어주세요!',
                            style: TextStyle(fontSize: 20), // 글자 크기 조정
                          )
                        else ...[
                          Text('나무 레벨: ${treeManager.tree.level}', style: TextStyle(fontSize: 20)), // 글자 크기 조정
                          SizedBox(height: 16),
                          Image.asset(
                            'assets/images/level${treeManager.tree.level}.png',
                            height: 150, // 이미지 높이 조정
                            width: 150, // 이미지 너비 조정
                          ),
                          SizedBox(height: 16),
                          Text('경험치: ${treeManager.tree.experience} / 3500', style: TextStyle(fontSize: 16)), // 글자 크기 조정
                          SizedBox(height: 16),
                          Container(
                            width: 250, // 경험치바 너비 조절
                            child: LinearProgressIndicator(
                              value: treeManager.tree.experience / 3500,
                              minHeight: 16, // 경험치바 높이 조절
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (treeManager.tree.level < 7 &&
                                  treeManager.tree.experience >= (treeManager.tree.level * 500) &&
                                  evolveItem.quantity > 0) {
                                treeManager.evolve();
                                itemData.useItem('진화!');
                              } else {
                                if (evolveItem.quantity == 0) {
                                  _showNoEvolveItemWarning(context);
                                } else {
                                  _showEvolveWarning(context);
                                }
                              }
                            },
                            child: Text('진화하기', style: TextStyle(fontSize: 16)), // 버튼 글자 크기 조정
                          ),
                        ],
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            treeManager.resetTree();
                          },
                          child: Text('초기화하기', style: TextStyle(fontSize: 16)), // 버튼 글자 크기 조정
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('아이템 사용하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // 글자 크기 조정
                  SizedBox(height: 10),
                  Consumer<ItemData>(
                    builder: (context, itemData, child) {
                      return Wrap(
                        spacing: 10,
                        children: [
                          _buildItemButton(context, itemData, '씨앗', Icons.grass, 0, isSeed: true),
                          _buildItemButton(context, itemData, '물', Icons.water_drop, 10),
                          _buildItemButton(context, itemData, '비료', Icons.eco, 20),
                          _buildItemButton(context, itemData, '영양제', Icons.local_florist, 50),
                          _buildItemButton(context, itemData, '진화!', Icons.auto_awesome, 0, isEvolve: true),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemButton(BuildContext context, ItemData itemData, String itemName, IconData icon, int exp,
      {bool isEvolve = false, bool isSeed = false}) {
    final treeManager = Provider.of<TreeManager>(context, listen: false);
    final item = itemData.items.firstWhere((item) => item.name == itemName);
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 32), // 아이콘 크기 조정
          onPressed: item.quantity > 0
              ? () {
                  if (isSeed) {
                    treeManager.plantSeed();
                  } else if (isEvolve) {
                    if (treeManager.tree.experience >= (treeManager.tree.level * 500) &&
                        item.quantity > 0) {
                      treeManager.evolveWithItem();
                      itemData.useItem(itemName);
                    } else {
                      if (item.quantity == 0) {
                        _showNoEvolveItemWarning(context);
                      } else {
                        _showEvolveWarning(context);
                      }
                    }
                  } else {
                    treeManager.addExperience(exp);
                    itemData.useItem(itemName);
                  }
                }
              : null,
        ),
        Text('$itemName (${item.quantity})', style: TextStyle(fontSize: 14)), // 글자 크기 조정
      ],
    );
  }

  void _showEvolveWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('경고'),
          content: Text('진화하기 위해서는 더 많은 경험치가 필요합니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNoEvolveItemWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('경고'),
          content: Text('진화 아이템이 없습니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
