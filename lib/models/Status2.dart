import 'package:flutter/material.dart';

class Status2{
  final String name;
  final String description;
  final String location;
  final String typeOfMeet;
  final String time;
   String? photoUrl;
   final String? uid;
  Status2({required this.name, required this.description, required this.location,required this.typeOfMeet,required this.time, this.photoUrl, this.uid});

}