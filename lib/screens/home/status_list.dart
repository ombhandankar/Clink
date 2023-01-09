import 'package:chumma/models/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chumma/screens/home/status_tile.dart';
import 'add_status.dart';

class StatusList extends StatefulWidget {
  const StatusList({Key? key}) : super(key: key);

  @override
  State<StatusList> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  @override
  Widget build(BuildContext context) {
    final statuses = Provider.of<List<Status>>(context);

    return Scaffold(
      body: ListView.builder(
          itemCount:statuses.length,
          itemBuilder:(context,index){
            return StatusTile(status:statuses[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>const StatusForm()));
        },
        child: const Icon(Icons.add),

      ),


    );

  }
}
