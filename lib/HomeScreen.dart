// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Your Work",style:TextStyle(fontSize:30,color:Colors.white)),
        backgroundColor: Colors.pink[800],
      ),
      body:Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        child:Icon(Icons.add,color:Colors.white),
        backgroundColor: Colors.pink[800],
      ),
    );
  }
}