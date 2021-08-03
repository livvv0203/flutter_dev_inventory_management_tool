import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:inventory_management_tool/data_models/item.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// Objects that are provided through out the Widget Trees
/// Other objects can listen for changes and update when we tell them to
class ItemData extends ChangeNotifier {
  List<dynamic>? allItemTitle;
  List<dynamic>? allItemCategory;
  List<dynamic>? allItemSender;

  /// Getting all the documents inside 'items' collection, print out what we need
  /// This is a Future snapshot
  Future<List?> getItemData() async {
    final items = await _firestore
        .collection('items')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.map((doc) => doc.data()).toList());
      allItemTitle = querySnapshot.docs.map((doc) => doc['title']).toList();
      allItemCategory =
          querySnapshot.docs.map((doc) => doc['category']).toList();
      allItemSender = querySnapshot.docs.map((doc) => doc['user']).toList();
      print(allItemSender);
      print(allItemTitle);
      print(allItemCategory);
      return _items;
    });
    return allItemTitle;
  }

  List<Item> _items = [
    // Item(itemTitle: 'Item 1', itemCategory: 'Category 1'),
  ];

  /// Add a new item to Firebase Collection
  void addDatabaseItem() {
    for (int i = 0; i < allItemTitle!.length; i++) {
      final item = new Item(
        itemTitle: allItemTitle![i],
        itemCategory: allItemCategory![i],
        itemSender: allItemSender![i],
      );
      _items.add(item);
    }

    /// Call the notify listener when done
    notifyListeners();
  }

  /// Getter, view of another List
  UnmodifiableListView<Item> get items {
    return UnmodifiableListView(_items);
  }

  /// Getter of Item Count
  int get itemCount {
    return _items.length;
  }

  /// Add a new item to Firebase Collection
  void addItem(String newItemTitle, String newItemCategory, String newItemSender) {
    final item = Item(itemTitle: newItemTitle, itemCategory: newItemCategory, itemSender: newItemSender);
    // _items.add(Item(itemTitle: 'aaa', itemCategory: 'bbb'));
    _items.add(item);

    /// Call the notify listener when done
    notifyListeners();
  }

  void deleteItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}

/// Notes: Get Firebase data as Map
// List<Item> _items = [
//   Item(itemTitle: 'Title', itemCategory: 'Category'),
// ];

// Test: jieqing@gmail.com
// /// Getting all the documents inside 'items' collection, print out what we need
// /// This is a Future snapshot
// void getItemTitle() async {
//   final items = await _firestore
//       .collection('items')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       // print(doc.data());
//       print(doc['title']);
//       // _items = [Item(itemTitle: doc['title'], itemCategory: doc['category'])];
//       // print(doc['title'] + doc['category']);
//     });
//   });
// }

// List<Item> _items = [
//   for (int i = 0; i < 3; i++)
//     Item(itemTitle: i.toString(), itemCategory: 'num'),
// ];
