import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;





    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Notification').doc(user?.uid).collection('notifications').snapshots(),
        builder: (context,snapshot) {
          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator(),)
              : ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                return new ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    data.get('Name'),
                    textScaleFactor: 1.5,
                  ),
                  trailing: Icon(Icons.celebration),
                  subtitle: Text('Has Clinked'),

                );
              });
        },
      ),
    );
  }
}
