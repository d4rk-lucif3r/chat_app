import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AuthScreen(),
    );
  }
}
