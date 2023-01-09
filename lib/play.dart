import 'package:flutter/material.dart';
import './models/Status2.dart';
import './screens/home/add_status.dart';
import 'package:provider/provider.dart';

class StatusView extends StatelessWidget {



   StatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final statuses = Provider.of<List<Status2>?>(context);

    Widget buildStatus(BuildContext context, int index)
    {
      final status = statuses?[index];
      return new Container(
        child: Card(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    ImageIcon(NetworkImage(status?.photoUrl ?? 'https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png')),
                    Text(status?.name ?? 'om', style: new TextStyle(fontSize: 30.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Icon(Icons.place_rounded),
                    Text(
                        status?.location ?? 'o',style: new TextStyle(fontSize: 10.0)),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Icon(Icons.people_rounded),
                    Text(
                        status?.typeOfMeet ?? 'o',style: new TextStyle(fontSize: 10.0)),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 30.0),
                  child: Row(children: <Widget>[
                    Icon(Icons.access_time_filled),
                    Text(
                        status?.time ?? 'o',style: new TextStyle(fontSize: 10.0)),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                  child: Row(
                    children: <Widget>[
                      Text(status?.description ?? 'o', style: new TextStyle(fontSize: 20.0),),
                      Spacer()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: new ListView.builder(
          itemCount: statuses?.length,
          itemBuilder: (BuildContext context, int index) => buildStatus(context,index)),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>const StatusForm()));
        },
        child: const Icon(Icons.add),

      ),

    );


  }


}

