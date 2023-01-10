import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:chumma/services/database.dart';


class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User?
    user = FirebaseAuth.instance.currentUser;
    DatabaseService databaseService = DatabaseService();

    if (user != null) {

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user.displayName ?? ''),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(user.email ?? '', style: Theme.of(context).textTheme.bodyLarge),
              Spacer(),
             ElevatedButton(
                 onPressed: ()  {
                   print('hemloo');
                   databaseService.deleteMyStatusManually();},
                 child: Text('Delete Status'))
             // Image.network(user.photoURL ?? ''

               // )
            ],
          ),
        ),
      );
    } else {
      return Text('not logged in...');
    }
  }

}
