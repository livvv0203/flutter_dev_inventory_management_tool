import 'package:flutter/material.dart';
import 'package:inventory_management_tool/screens/register_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  /// To make id associate with this class
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Inventory Book',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          TextButton(
              onPressed: () {
                // Go to Login Screen
                Navigator.pushNamed(
                  context,
                  LoginScreen.id,
                );
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
              // Go to Login Screen
              Navigator.pushNamed(
                context,
                RegisterScreen.id,
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}







