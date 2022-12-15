import 'package:codigo/screens/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyPasswords());

}

class MyPasswords extends StatelessWidget{
  const MyPasswords({super.key});


  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Login(),

    );
  }

}


