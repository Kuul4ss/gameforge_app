import 'package:flutter/material.dart';
import 'package:gameforge_app/models/entities/user_manager.dart';
import '../models/either/either.dart';
import '../models/entities/user.dart';

import '../services/service_api.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({Key? key}) : super(key: key);

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  List<User> _friendRequesterList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriendRequests();
  }

  _loadFriendRequests() async {
    final api = ServiceAPI();
    final result = await api.getAskedRequests(UserManager.currentUser!.token);

    if (result is Success<List<User>, String>) {
      setState(() {
        _friendRequesterList = result.value;
        _isLoading = false;
      });
    } else if (result is Failure<List<User>, String>) {
      //erreur
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyContent(),
    );
  }

  Widget buildBodyContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _friendRequesterList.length,
        itemBuilder: (context, index) {
          final request = _friendRequesterList[index];
          return ListTile(
            title: Text(request.pseudo),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () async {
                    await ServiceAPI().acceptFriend(UserManager.currentUser!.token,_friendRequesterList[index].token);
                    _loadFriendRequests();
                    setState(() {
                      _friendRequesterList.removeAt(index);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () async {
                    await ServiceAPI().deleteFriend(UserManager.currentUser!.token,_friendRequesterList[index].token);
                    _loadFriendRequests();
                    setState(() {
                      _friendRequesterList.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
