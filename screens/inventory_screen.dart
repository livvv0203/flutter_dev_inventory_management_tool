import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_tool/data_models/item_data.dart';
import 'package:inventory_management_tool/screens/welcome_screen.dart';
import 'package:inventory_management_tool/widgets/inventory_list.dart';
import 'package:provider/provider.dart';
import 'add_item_screen.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class InventoryScreen extends StatefulWidget {

  static const id = 'inventory_screen';

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _userAuthentication = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _itemsStream = FirebaseFirestore.instance
      .collection('items')
      .snapshots();

  @override
  void initState() {
    // implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddItemScreen(),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        /// Get back to the Welcome Screen
                        _userAuthentication.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Column(
                    children: <Widget>[
                      Text(
                        loggedInUser.displayName.toString() +
                            ' \'s Inventory List',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        'Total Items: ${Provider.of<ItemData>(context).itemCount}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  // color: Colors.black26,
                ),
                // child: InventoryList(itData: _itemDataInstance,),
                child: InventoryList(),
              ),
            ),
            SizedBox(height: 90.0),
          ],
        ),
      ),
    );
  }
}
