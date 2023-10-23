import 'package:flutter/material.dart';
import 'package:gameforge_app/models/entities/user_manager.dart';
import 'package:gameforge_app/ui/lists_screen.dart';
import 'package:gameforge_app/ui/search_user.dart';

import 'friend_requests_screen.dart';

class ConnectedMenuPage extends StatefulWidget {
  const ConnectedMenuPage({super.key});

  static const routeName = '/connected-menu';

  @override
  State<ConnectedMenuPage> createState() =>
      _ConnectedMenuPage();
}

class _ConnectedMenuPage
    extends State<ConnectedMenuPage> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
    const ListsScreen(),
    const SearchUser(),
    const FriendRequestsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(UserManager.currentUser!.pseudo),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'amis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Demandes',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}