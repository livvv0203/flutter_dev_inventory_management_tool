import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_tool/data_models/item_data.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _userAuthentication = FirebaseAuth.instance;

  final itemTitleController = TextEditingController();
  final itemCategoryController = TextEditingController();

  @override
  void initState() {
    // implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    // Check if there's a current user
    try {
      final user = _userAuthentication.currentUser;
      loggedInUser = user!;
      print(loggedInUser.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    itemTitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Reference the Firestore collection
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    Future<void> addItem() {
      return items
          .add({
        'user': loggedInUser.displayName.toString(),
        'title': itemTitleController.text,
        'category': itemCategoryController.text,
        'time': Timestamp.now(),
      })
          .then((value) => print("New Item Added"))
          .catchError(
              (error) => print("Failed to add user: $error"));
    }
    // items.sort((a , b ) => b.time.compareTo(a.time));

    return Container(
      color: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add an Item',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: itemTitleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Item Name',
                contentPadding: EdgeInsets.all(10.0),
              ),
              // onChanged: (newText) {
              //   newItemTitle = newText;
              // },
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: itemCategoryController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Category Name',
                contentPadding: EdgeInsets.all(10.0),
              ),
              // onChanged: (newCategory) {
              //   newItemCategory = newCategory;
              // },
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 7, horizontal: 30)),
              ),
              onPressed: () {
                addItem();
                Provider.of<ItemData>(context, listen: false).addItem(
                  itemTitleController.text,
                  itemCategoryController.text,
                  loggedInUser.displayName.toString(),
                );
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
