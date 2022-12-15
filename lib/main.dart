import 'package:codigo/screens/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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


