import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_tool/screens/inventory_screen.dart';
import 'package:inventory_management_tool/screens/welcome_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// Authentication
  final _userAuthentication = FirebaseAuth.instance;
  late String userEmail;
  late String userPassword;
  late String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Create a Username',
                contentPadding: EdgeInsets.all(10.0),
              ),
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Create an account by email',
                contentPadding: EdgeInsets.all(10.0),
              ),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userEmail = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Create a password',
                contentPadding: EdgeInsets.all(10.0),
              ),
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userPassword = value;
              },
            ),

            SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                try {
                  final newUser = await _userAuthentication.createUserWithEmailAndPassword(
                    email: userEmail,
                    password: userPassword,
                  );
                  await _userAuthentication.currentUser!.updateDisplayName(userName);
                  /// Get into the Inventory App
                  Navigator.pushNamed(context, InventoryScreen.id);
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Log out: Go back to the Welcome Screen
                _userAuthentication.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
