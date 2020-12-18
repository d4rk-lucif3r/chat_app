import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String password,
    String username,
    String email,
    bool isLogin,
    File imageFile,
  ) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        final uploadedImageRef = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(userCredential.user.uid + '.jpg');
        await uploadedImageRef.putFile(imageFile);
        final userImageUrl = await uploadedImageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': username,
          'email': email,
          'userImageUrl': userImageUrl,
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        message = error.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: Text(message),
        elevation: 10,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        message = error.message.toString();
      }
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: Text(message),
        elevation: 10,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
