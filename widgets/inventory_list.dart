import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_tool/data_models/item.dart';
import 'inventory_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management_tool/data_models/item_data.dart';

// FirebaseFirestore _firestore = FirebaseFirestore.instance;

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {

  void initState() {
    // implement initState
    super.initState();
    initDataHandling(context);
  }

  bool _initDataHandled = false;
  void initDataHandling(BuildContext context) async {

    // await new Future.delayed(const Duration(seconds: 3));
    ItemData contextProvidedItemData = Provider.of<ItemData>(context, listen: false);
    await contextProvidedItemData.getItemData();
    contextProvidedItemData.addDatabaseItem();
    _initDataHandled = true;
  }

  @override
  /// Information of where the widgets lives, is in BuildContext property
  Widget build(BuildContext context) {
    if (!_initDataHandled) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white10,
        body: SafeArea(
          child: Center(
            child: Text(
              "loading",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    /// Now that Consumer widget will be listening the change of itemData
    return Consumer<ItemData>(
      builder: (context, itemData, child) {

        return ListView.builder(

          itemBuilder: (context, index) {

            final item = itemData.items[index];
            CollectionReference items = FirebaseFirestore.instance.collection('items');

            Future<void> deleteItem() {
              return items
                  .where('title', isEqualTo: item.itemTitle)
                  .get().then((value) {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance.collection('items').doc(element.id)
                      .delete()
                      .then((value) {
                    print('Successfully Deleted!' + item.itemTitle.toString());
                  });
                });
              });
            }

            return InventoryListTile(
              // Here "widget" refers to the stateful widget
              itemTitle: item.itemTitle,
              itemCategory: item.itemCategory,
              itemSender: item.itemSender,
              longPressCallback: () {
                deleteItem();
                Provider.of<ItemData>(context, listen: false).deleteItem(item);
              },
            );
          },
          itemCount: itemData.itemCount,
        );
      },
    );
  }
}
