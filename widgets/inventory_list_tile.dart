import 'package:flutter/material.dart';

class InventoryListTile extends StatelessWidget {
  late final String? itemTitle;
  late final String? itemCategory;
  late final String? itemSender;
  final VoidCallback longPressCallback;

  InventoryListTile({
    this.itemTitle,
    this.itemCategory,
    required this.longPressCallback,
    this.itemSender,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(itemTitle!),
      subtitle: Text(itemCategory!),
      trailing: Text(itemSender!),
    );
  }
}
