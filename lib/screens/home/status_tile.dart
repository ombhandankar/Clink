import 'package:flutter/material.dart';
import 'package:chumma/models/status.dart';

class StatusTile extends StatelessWidget {
  final Status status;
  const StatusTile({Key? key,required this.status}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top:8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('person.jpg')
            ),
            title: Text(status.name),
            subtitle: Text('Is current at ${status.location} for ${status.duration} time'),

          ),
        ),
    );
  }
}
