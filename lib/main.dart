// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var name = prefs.getString('name');
  var photo = prefs.getString('photo');
  if(email==null){
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
  else{
    print("Your email is  $email and name is $name");
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(Email: email, Name: name!, Photo: photo!),
      ),
    );
  }
}
