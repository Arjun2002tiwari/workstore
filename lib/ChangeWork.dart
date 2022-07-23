// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Database.dart';

class ChangeWork extends StatefulWidget {
  String Email="";
  late DateTime Date;
  String Work="";
  String id="";

  ChangeWork({Key? key,required this.Email, required this.Date, required this.Work, required this.id}) : super(key: key);

  @override
  State<ChangeWork> createState() => _ChangeWorkState();
}

class _ChangeWorkState extends State<ChangeWork> {
  TextEditingController _dateinput=new TextEditingController();
  TextEditingController _work=new TextEditingController();
  DateTime today=DateTime.now();

  void initState() {
    super.initState();
    _dateinput.text='${widget.Date.day}-${widget.Date.month}-${widget.Date.year}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Work",style:TextStyle(fontSize: 30)),
        backgroundColor: Colors.pink[800],
      ),
    body: Center(
      child:Container(
        padding:EdgeInsets.all(20),
        child:ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height:MediaQuery.of(context).size.height*0.1,
            ),
            Center(
            child:Text("Change Work",style:TextStyle(fontSize: 40,color:Colors.blue[900],fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height:30,
            ),
            TextField(
              controller:_work,
              decoration: InputDecoration(
                labelText: "Work Name",
                hintText:widget.Work,
                labelStyle: TextStyle(fontSize: 20,color:Colors.pink[800],fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height:30,
            ),
            TextField(
              controller: _dateinput,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon:Icon(Icons.calendar_today),
                  onPressed:(){
                    selectDate(context);
                  },
                ),
                labelText: "Select Date",
                labelStyle: TextStyle(fontSize: 20,color:Colors.pink[800],fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              readOnly: true,
            ),
            SizedBox(
              height:30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width/3,MediaQuery.of(context).size.height/15),
                  ),
                onPressed: (){
                  _work.clear();
                  _dateinput.clear();
                  Navigator.pop(context);
                }, 
                child:Text("Cancel",style:TextStyle(fontSize:20,color:Colors.black,fontWeight:FontWeight.bold)),
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width/3,MediaQuery.of(context).size.height/15),
                  ),
                onPressed: (){
                  FirebaseFirestore.instance.collection('Work').doc(widget.Email).collection('worklist').doc(widget.id).update({
                    'Work': _work.text,
                    'Date': today,
                  });
                  Navigator.pop(context);
                }, 
                child:Text("Create",style:TextStyle(fontSize:20,color:Colors.white,fontWeight:FontWeight.bold)),
                ),
              ],
            ), 
            ],
          ),
      )
      ),
    );
  }
  Future<void> selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),);

    if(pickedDate!=null && pickedDate!=today){
      setState(() {
        today=pickedDate;
        _dateinput.text='${today.day}-${today.month}-${today.year}';
      });
    }
  }
}

