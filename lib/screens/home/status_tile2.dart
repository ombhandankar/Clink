import 'package:flutter/material.dart';

class StatusTile2 extends StatelessWidget {

  StatusTile2({
    super.key,
    required this.name,
    required this.duration,
    required this.location,
    required this.description,
  });

  final String name;
  final String location;
  final String description;
  final int duration;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Expanded(
            flex: 3,
            child: _Details(name: name, description: description, duration: duration)
          ),
          const Icon(
            Icons.thumb_up_sharp,
            size: 16.0,
          ),
          const Icon(
            Icons.thumb_down_alt_sharp,
            size: 16.0,
          ),
        ],
      ),
    );;
  }
}

class _Details extends StatelessWidget {
  const _Details({
    required this.name,
    required this.description,
    required this.duration,
  });

  final String name;
  final String description;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$duration time',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class StatusTiles2 extends StatelessWidget {
  final StatusTile2 status;
  const StatusTiles2({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 106.0,
      children: <StatusTile2>[
        StatusTile2(
            name: status.name,
            duration: status.duration,
            location: status.location,
            description: status.description
        )],
    );
  }
}
