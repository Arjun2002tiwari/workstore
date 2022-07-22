// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var reslut = await googleSignIn.signIn();
      if (reslut == null) {
        return;
      }
      
      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      String name=reslut.displayName.toString();
      String email=reslut.email.toString();
      String photo=reslut.photoUrl.toString();
      // print(reslut.photoUrl);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return HomeScreen(Email:email,Name:name,Photo:photo);
    }));

    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue,Colors.greenAccent, Colors.pinkAccent],
          ),
        ),
        child:Center(
          child:Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text("Register now!",style:TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: Colors.white,
                    padding: EdgeInsets.all(15),
                    minimumSize: Size(double.infinity,50),
                  ),
                onPressed: () {
                  googleLogin();
                }, 
                child: Text("Sign In with google",style:TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                ),
            ],),
          ),
        ),
      ),  
    );
  }
}