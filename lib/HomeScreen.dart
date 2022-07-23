// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'AddWork.dart';
import 'ChangeWork.dart';
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
  bool sort=false;
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
            ListTile(
              title: Text("Sort By"),
              trailing: Icon(Icons.sort,color:sort?Colors.pink[800]:Colors.grey),
              onTap: (){
                setState(() {
                  sort=!sort;
                });
              },
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child:Column(
        children:[
          Container(
            child:ShowWork(id:widget.Email,sort:sort),
          ),
        ],
       ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context){
           return AddWork(Email:widget.Email);
         }));
        },
        child:Icon(Icons.add,color:Colors.white),
        backgroundColor: Colors.pink[800],
      ),
    );
  }
}
class ShowWork extends StatefulWidget {
  String id="";
  late bool sort;
  ShowWork({Key? key,required this.id, required this.sort}) : super(key: key);

  @override
  State<ShowWork> createState() => _ShowWorkState();
}

class _ShowWorkState extends State<ShowWork> {
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('Work').doc(widget.id).collection('worklist').orderBy('Date').snapshots(),
      builder:(context,snapshot){
        if(!snapshot.hasData){  
          return Center(
            child:CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary:true,
          reverse:widget.sort,
          itemCount:snapshot.data!.docs.length,
          itemBuilder:(context,index){
          QueryDocumentSnapshot x=snapshot.data!.docs[index];
          DateTime date=x['Date'].toDate();
          return ListTile(
            tileColor:isSelected?Colors.teal[500]:Colors.grey[300],
            shape:RoundedRectangleBorder(
              side:BorderSide(color:Colors.white,width:1),
              borderRadius:BorderRadius.circular(5)
            ),

            title:Text(x['Work'],style:isSelected?TextStyle(fontSize:20,color:Colors.white,fontWeight:FontWeight.bold):TextStyle(fontSize:20,color:Colors.blue[900],fontWeight: FontWeight.bold)),

            subtitle:Text('Date:${date.day}/${date.month}/${date.year}',style:isSelected?TextStyle(fontSize:15,color:Colors.white,fontWeight:FontWeight.bold):TextStyle(fontSize:15,color:Colors.blue[900],fontWeight: FontWeight.bold)),

            leading:IconButton(
              icon:isSelected?Icon(Icons.check_box,color:Colors.white):Icon(Icons.check_box_outline_blank,color:Colors.pink[800]),
              onPressed: (){
                setState(() {
                  isSelected=!isSelected;
                });
              },
          ),
          trailing:IconButton(
            icon:Icon(Icons.edit_note,color:Colors.pink[800],size:45),
            onPressed: isSelected?null:(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ChangeWork(Email:widget.id,Work:x['Work'],Date:date,id:x.id);
              }));
            }
          ),
          onLongPress: (){
            showAlert(context,x.id);
          },
          );
          },
          );
        });
  }
  
  void showAlert(BuildContext context, String id) {
    var alertDialog = AlertDialog(
      title: Text("Delete",style:TextStyle(fontSize:30,color:Colors.red,fontWeight:FontWeight.bold)),
      content: Text("Are you sure you want to delete this work?",style:TextStyle(fontSize:20,color:Colors.blue,fontWeight:FontWeight.bold)),
      actions: <Widget>[
        ElevatedButton(
          style:ElevatedButton.styleFrom(
            primary:Colors.red[600],
          ),
          child: Text("Yes"),
          onPressed: (){
            FirebaseFirestore.instance.collection('Work').doc(widget.id).collection('worklist').doc(id).delete();
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          style:ElevatedButton.styleFrom(
            primary:Colors.green[600],
          ),
          child: Text("No"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }
}