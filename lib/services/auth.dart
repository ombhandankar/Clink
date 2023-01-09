import 'dart:async';


import 'package:chumma/models/user.dart';
import 'package:chumma/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? _userFromFirebaseUser(User? user){
    if(user!=null)
      {
        return MyUser(uid: user.uid);
      }
    else
      return null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map( _userFromFirebaseUser); //maps the incoming users to our defined user models
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
        print(e.toString());
        return null; 
    }
  }
  //sign in email
  Future signInWithEmail(String email,String password) async
  {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in phone no

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register
  Future registerWithEmail(String name,String email,String password,String? photoUrl) async
  {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user in database
      await user?.updateDisplayName(name);
      await user?.updatePhotoURL(photoUrl);

      //await DatabaseService(uid: user?.uid).updateUserData('new user', 'bms', 10);
      return _userFromFirebaseUser(user);
  }catch(e){
      print(e.toString());
      return null;
    }
  }




}

