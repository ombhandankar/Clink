import 'package:chumma/models/status.dart';
import 'package:chumma/models/Status2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DatabaseService
{
  final String? uid;
  DatabaseService({ this.uid});

  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference statusCollection =   FirebaseFirestore.instance.collection('Statuss');

  final CollectionReference status2Collection =   FirebaseFirestore.instance.collection('Status');



  Future updateUserData(String name,String location,int duration) async{
    return await statusCollection.doc(uid).set({
      'name': name,
      'location': location,
      'duration': duration
    });
  }

  Future updateUserStatus(String description,String location,String typeOfMeet, String time) async
  {
    return await status2Collection.doc(uid).set({
      'name' : user?.displayName,
      'description' : description,
      'location' : location,
      'typeOfMeet': typeOfMeet,
      'time': time,
      'photoUrl': user?.photoURL
    });
  }


  //status list from snapshot
  List<Status> _statusListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Status(
          name: doc.get('name') ?? '',
          location: doc.get('location') ?? '0',
          duration : doc.get('duration') ?? 0
      );
    }).toList();
  }

  //status list from snapshot
  List<Status2> _status2ListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Status2(
          name: doc.get('name') ?? 'user',
          location: doc.get('location') ?? 'bms',
          description: doc.get('description') ?? 'nothing',
          typeOfMeet: doc.get('typeOfMeet') ?? 'normal',
          time: doc.get('time') ?? '',
          photoUrl: doc.get('photoUrl') ?? ''
      );
    }).toList();
  }

  //get status stream
  Stream<List<Status>> get status
  {
    return statusCollection.snapshots().map(_statusListFromSnapShot);
  }

  Stream<List<Status2>> get status2
  {
    return status2Collection.snapshots().map(_status2ListFromSnapShot);
  }
}

