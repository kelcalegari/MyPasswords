import 'package:codigo/screens/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyPasswords());
}

class MyPasswords extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }

}


