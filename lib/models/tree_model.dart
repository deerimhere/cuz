import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tree {
  int experience;
  int level;
  List<bool> evolutionStages;

  Tree({this.experience = 0, this.level = 1, List<bool>? evolutionStages})
      : evolutionStages = evolutionStages ?? [false, false, false, false];

  void addExperience(int exp) {
    experience += exp;
    if (experience >= 10000) {
      experience = 10000;
    }
  }

  void evolve() {
    if (experience >= level * 2500 && level < 4) {
      level++;
    }
  }

  void evolveWithItem() {
    if (level < 4) {
      if (experience >= 2500 && !evolutionStages[0]) {
        level++;
        evolutionStages[0] = true;
      } else if (experience >= 5000 && !evolutionStages[1]) {
        level++;
        evolutionStages[1] = true;
      } else if (experience >= 7500 && !evolutionStages[2]) {
        level++;
        evolutionStages[2] = true;
      } else if (experience >= 10000 && !evolutionStages[3]) {
        level++;
        evolutionStages[3] = true;
      }
    }
  }
}

class TreeManager extends ChangeNotifier {
  Tree _tree = Tree();

  Tree get tree => _tree;

  Future<void> loadTree() async {
    final prefs = await SharedPreferences.getInstance();
    _tree.experience = prefs.getInt('treeExperience') ?? 0;
    _tree.level = prefs.getInt('treeLevel') ?? 1;
    _tree.evolutionStages = [
      prefs.getBool('evolutionStage0') ?? false,
      prefs.getBool('evolutionStage1') ?? false,
      prefs.getBool('evolutionStage2') ?? false,
      prefs.getBool('evolutionStage3') ?? false,
    ];
    notifyListeners();
  }

  Future<void> saveTree() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('treeExperience', _tree.experience);
    await prefs.setInt('treeLevel', _tree.level);
    await prefs.setBool('evolutionStage0', _tree.evolutionStages[0]);
    await prefs.setBool('evolutionStage1', _tree.evolutionStages[1]);
    await prefs.setBool('evolutionStage2', _tree.evolutionStages[2]);
    await prefs.setBool('evolutionStage3', _tree.evolutionStages[3]);
  }

  void addExperience(int exp) {
    _tree.addExperience(exp);
    saveTree();
    notifyListeners();
  }

  void evolve() {
    _tree.evolve();
    saveTree();
    notifyListeners();
  }

  void evolveWithItem() {
    _tree.evolveWithItem();
    saveTree();
    notifyListeners();
  }
}
