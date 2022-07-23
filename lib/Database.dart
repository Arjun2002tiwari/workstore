import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

  void uploadWork(String text, String email, DateTime today) {
    FirebaseFirestore.instance.collection('Work').doc(email).collection('worklist').add({
      'Work': text,
      'Date': today,
    });
  }
}