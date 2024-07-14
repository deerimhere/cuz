import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final IconData icon;
  final String name;
  final int price;
  bool purchased;
  int quantity;

  Item({
    required this.icon,
    required this.name,
    required this.price,
    this.purchased = false,
    this.quantity = 0,
  });

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
      name: data['name'],
      price: data['price'],
      purchased: data['purchased'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon.codePoint,
      'name': name,
      'price': price,
      'purchased': purchased,
      'quantity': quantity,
    };
  }
}

class ItemData extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userId = "user-id"; // 실제 유저 ID를 여기에 설정

  List<Item> _items = [];

  List<Item> get items => _items;

  ItemData() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_userId).get();
    if (snapshot.exists) {
      List<dynamic> itemList = snapshot['items'];
      _items = itemList.map((item) => Item.fromMap(item)).toList();
      notifyListeners();
    }
  }

  Future<void> purchaseItem(int index) async {
    _items[index].quantity++;
    if (_items[index].name == '씨앗') {
      _items[index].purchased = true;
    }
    await _firestore.collection('users').doc(_userId).update({
      'items': _items.map((item) => item.toMap()).toList(),
    });
    notifyListeners();
  }

  Future<void> useItem(String itemName) async {
    final item = _items.firstWhere((item) => item.name == itemName);
    if (item.quantity > 0) {
      item.quantity--;
      await _firestore.collection('users').doc(_userId).update({
        'items': _items.map((item) => item.toMap()).toList(),
      });
      notifyListeners();
    }
  }
}
