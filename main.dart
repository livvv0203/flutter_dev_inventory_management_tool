import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_tool/screens/inventory_screen.dart';
import 'package:inventory_management_tool/screens/login_screen.dart';
import 'package:inventory_management_tool/screens/register_screen.dart';
import 'package:inventory_management_tool/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'data_models/item_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InventoryApp());
}

class InventoryApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Providing the Item Data Objects
      create: (context) => ItemData(),
      child: MaterialApp(
        title: 'Inventory App',
        theme: ThemeData.dark(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          InventoryScreen.id: (context) => InventoryScreen(),
        }
      ),
    );
  }
}








