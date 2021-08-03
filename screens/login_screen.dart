import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_tool/screens/inventory_screen.dart';
import 'package:inventory_management_tool/screens/register_screen.dart';
import 'package:inventory_management_tool/screens/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userAuthentication = FirebaseAuth.instance;
  late String userEmail;
  late String userPassword;

  @override
  void initState() {
    // implement initState
    super.initState();
  }

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
                hintText: 'Enter email',
                contentPadding: EdgeInsets.all(10.0),
              ),
              onChanged: (value) {
                userEmail = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
                contentPadding: EdgeInsets.all(10.0),
              ),
              obscureText: true,
              onChanged: (value) {
                userPassword = value;
              },
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () async {
                // Get into the App content
                try {
                  final user =
                      await _userAuthentication.signInWithEmailAndPassword(
                    email: userEmail,
                    password: userPassword,
                  );
                  Navigator.pushNamed(context, InventoryScreen.id);
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                /// Get back to the Welcome Screen
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
