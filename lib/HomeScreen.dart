// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'AddWork.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  String Email="";
  String Name="";
  String Photo="";
  HomeScreen({Key? key, required this.Email, required this.Name, required this.Photo}) : super(key: key);

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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.Photo),
              ),
              accountName: Text(widget.Name),
              accountEmail: Text(widget.Email),
            ),
            ListTile(
              title:Text("Profile"),
              trailing: Icon(Icons.person),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfileScreen(Email:widget.Email,Name:widget.Name,Photo:widget.Photo);
                }));
              },
            ),
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.home),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context){
           return AddWork();
         }));
        },
        child:Icon(Icons.add,color:Colors.white),
        backgroundColor: Colors.pink[800],
      ),
    );
  }
}