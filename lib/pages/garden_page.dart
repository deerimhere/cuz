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
                            style: TextStyle(fontSize: 24),
                          )
                        else ...[
                          Text('나무 레벨: ${treeManager.tree.level}', style: TextStyle(fontSize: 24)),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/images/level${treeManager.tree.level}.png',
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(height: 20),
                          Text('경험치: ${treeManager.tree.experience} / 3500', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 20),
                          Container(
                            width: 300, // 경험치바의 길이를 조절합니다.
                            child: LinearProgressIndicator(
                              value: treeManager.tree.experience / 3500,
                              minHeight: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: treeManager.tree.level < 7 &&
                                    treeManager.tree.experience >= (treeManager.tree.level * 500) &&
                                    evolveItem.quantity > 0
                                ? () {
                                    treeManager.evolve();
                                    itemData.useItem('진화!');
                                  }
                                : null,
                            child: Text('진화하기'),
                          ),
                        ],
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            treeManager.resetTree();
                          },
                          child: Text('초기화하기'),
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
                  Text('아이템 사용하기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          icon: Icon(icon, size: 40),
          onPressed: item.quantity > 0
              ? () {
                  if (isSeed) {
                    treeManager.plantSeed();
                  } else if (isEvolve) {
                    treeManager.evolveWithItem();
                  } else {
                    treeManager.addExperience(exp);
                  }
                  itemData.useItem(itemName);
                }
              : null,
        ),
        Text('$itemName (${item.quantity})'),
      ],
    );
  }
}
