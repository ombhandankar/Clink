import 'package:chumma/screens/profile.dart';
import 'package:chumma/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:chumma/services/database.dart';
import 'package:provider/provider.dart';
import 'package:chumma/screens/home/status_list.dart';
import 'play.dart';
import '../../models/status.dart';
import 'bottom_Nav.dart';
import '../../models/menuItem.dart';
import '../../screens/notifications.dart';
import 'package:chumma/models/Status2.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

 final _buildBody =  <Widget>[StatusView(), Notifications(),ProfilePage()];
  int index =0;
  final menuItemList = const<MenuItemm>[
    MenuItemm(iconData: Icons.home, text: 'Home'),
    MenuItemm(iconData: Icons.notifications, text: 'Notifications'),
    MenuItemm(iconData: Icons.person, text: 'Me')
  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Status2>?>.value(
      value: DatabaseService().status2,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('Status'),
          backgroundColor: Colors.blue[200],
          elevation: 0.0,
          actions:<Widget>[
            TextButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _authService.signOut();
                },
                )
          ],
        ),
        body: _buildBody[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (x){
            setState(() {
              index =x;
            });
    },
          items: menuItemList.map((MenuItemm menuItemm) => BottomNavigationBarItem(
          icon: Icon(menuItemm.iconData),
          label: menuItemm.text)).toList(),
        ),
        ),
      );
  }
}
