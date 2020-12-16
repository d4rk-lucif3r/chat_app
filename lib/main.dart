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
        accentColor: Colors.amberAccent,
        backgroundColor: Colors.black,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.amberAccent,
            disabledColor: Colors.grey,
            hoverColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textTheme: ButtonTextTheme.normal),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Theme.of(context).primaryColor,
          elevation: 10,
          shadowColor: Colors.white10,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          shadowColor: Colors.blueGrey,
          margin: const EdgeInsets.all(10),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        dialogTheme: DialogTheme(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: AuthScreen(),
    );
  }
}
