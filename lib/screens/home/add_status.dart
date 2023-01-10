import 'package:flutter/material.dart';
import 'package:time/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chumma/shared/loading.dart';
import 'package:chumma/services/database.dart';
import 'package:chumma/play.dart';

class StatusForm extends StatefulWidget {
  const StatusForm({Key? key}) : super(key: key);

  @override
  State<StatusForm> createState() => _StatusFormState();
}

class _StatusFormState extends State<StatusForm> {
  @override


  User? user = FirebaseAuth.instance.currentUser;


  TimeOfDay time = TimeOfDay.now();
  var error = '';
   String location = '';
   String description = '';
   String typeOfMeet = '';

  String currentValue = 'None';
  var typeOfMeets = [
    "Formal",
    "Informal",
    "Appointment",
    "None"
  ];

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user?.displayName ?? 'Your Status'),
        ),
        body:
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

            TextFormField(
            decoration: const InputDecoration(
                icon: const Icon(Icons.person),
          hintText: 'Enter Description',
          labelText: 'Description'),
              validator: (val) => val!.isEmpty ? 'Enter a basic description' : null ,
              onChanged: (val) {
              setState(() {
                description = val;
              });
              },
            ),

            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.location_on),
                  hintText: 'Enter Location',
                  labelText: 'Location'),
              validator: (val) => val!.isEmpty ? 'Enter your location' : null ,
              onChanged: (val) {
                setState(() {
                  location = val;
                });
              },
            ),

            DropdownButtonFormField(
              decoration: InputDecoration(
               labelText: 'Type of Meet',
                hintText: 'What kind of meeting is it?',
                icon: const Icon(Icons.people_alt)
              ),
              dropdownColor: Colors.greenAccent,
              value: currentValue,
              onChanged: (String? newValue) {
                setState(() {
                  currentValue = newValue!;
                  typeOfMeet = currentValue;

                });
              },
              items: typeOfMeets.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 40.0),
             child: Row(
              children:<Widget>[ Text(
                   '${time.hour }:${time.minute}'),
        Spacer(),
        ElevatedButton(
          child: Text('Select Time'),
          onPressed: () async{
              TimeOfDay? newTime= await showTimePicker(context: context,
                  initialTime: time
              );
              if (newTime == null) return;
              setState(() {
                time = newTime;
              });
          },
        )

             ]

),
           ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                    ),
                    child: Text('Upload',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {

                      if(_formKey.currentState!.validate())
                      {
                        String sTime = time.toString();
                       //  dynamic result =  await DatabaseService(uid: user?.uid).updateUserData('new user', 'bms', 10);
                        await DatabaseService(uid: user?.uid).updateUserStatus(description, location, typeOfMeet, sTime,user?.uid ?? '');
                        Navigator.push(context,MaterialPageRoute(builder:(context)=> StatusView()));
                      }
                      }

                ),

        ],
        
            ),
        ),
      ),
    );
  }
}
