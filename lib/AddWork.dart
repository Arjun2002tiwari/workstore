// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddWork extends StatefulWidget {
  const AddWork({Key? key}) : super(key: key);

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  DateTime today=DateTime.now();
  TextEditingController _dateinput=new TextEditingController();
  TextEditingController _work=new TextEditingController();

  void initState() {
    super.initState();
    _dateinput.text='${today.day}-${today.month}-${today.year}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Work",style:TextStyle(fontSize: 30)),
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
            child:Text("Add Work",style:TextStyle(fontSize: 40,color:Colors.blue[900],fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height:30,
            ),
            TextField(
              controller:_work,
              decoration: InputDecoration(
                labelText: "Work Name",
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
                onPressed: (){}, 
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

