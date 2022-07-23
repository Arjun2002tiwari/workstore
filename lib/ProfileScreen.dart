// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class ProfileScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String Photo="";
  String Name="";
  String Email="";
  ProfileScreen({Key? key, required this.Email, required this.Name, required this.Photo}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding:EdgeInsets.all(20),
        child:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height:MediaQuery.of(context).size.height*0.13,
              ),
              Text("Logged In!",style:TextStyle(fontSize: 40,color:Colors.blue[900],fontWeight: FontWeight.bold)),
              SizedBox(
                height:30,
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.Photo),
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.Name,style:TextStyle(fontSize:20,color:Colors.pink[800],fontWeight:FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(widget.Email,style:TextStyle(fontSize:20,color:Colors.pink[800],fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                  primary: Colors.pink[800],
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.08),
                ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('name');
                prefs.remove('email');
                prefs.remove('photo');
                print(prefs.getString('name'));
                await GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              }, 
              child:Text("Logout",style:TextStyle(fontSize:20,color:Colors.white,fontWeight:FontWeight.bold)),
              ),
            ],
          ),
          ),
        ),
    );
  }
}
