import 'package:flutter/material.dart';
import 'package:gameforge_app/ui/connected_menu_page.dart';
import 'package:gameforge_app/ui/login_page.dart';

import 'models/entities/user.dart';
import 'models/requests/login_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/connected-menu': (context) => ConnectedMenuPage(),
      },
    );
  }
}
