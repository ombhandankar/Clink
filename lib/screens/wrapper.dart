import 'package:chumma/models/user.dart';
import 'package:chumma/screens/authenticate/authenticate.dart';
import 'package:chumma/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final user = Provider.of<MyUser?>(context);
      //print(user);
      if(user == null)
        {
          return Authenticate();
        }
      else {
        return Home();
      }
  }
}
