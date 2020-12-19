import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import './screens/splash_screen.dart';

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
        primaryColor: Colors.red,
        accentColor: Colors.amberAccent,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
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
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              SplashScreen();
            }
            if (snapShot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}
