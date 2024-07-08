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
                child: Consumer<TreeManager>(
                  builder: (context, treeManager, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('나무 레벨: ${treeManager.tree.level}', style: TextStyle(fontSize: 24)),
                        SizedBox(height: 20),
                        Text('경험치: ${treeManager.tree.experience} / 10000', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: treeManager.tree.experience / 10000,
                          minHeight: 20,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: treeManager.tree.level < 4 &&
                                  treeManager.tree.experience >= treeManager.tree.level * 2500
                              ? () {
                                  treeManager.evolve();
                                }
                              : null,
                          child: Text('진화하기'),
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
                          _buildItemButton(context, itemData, '씨앗', Icons.grass, 0),
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
      {bool isEvolve = false}) {
    final treeManager = Provider.of<TreeManager>(context, listen: false);
    final item = itemData.items.firstWhere((item) => item.name == itemName);
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40),
          onPressed: item.quantity > 0
              ? () {
                  if (isEvolve) {
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
