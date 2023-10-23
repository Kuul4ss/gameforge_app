import 'package:flutter/material.dart';
import 'package:gameforge_app/models/entities/user_friend_or_not.dart';
import 'package:gameforge_app/models/entities/user_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../models/either/either.dart';
import '../models/entities/user.dart';
import '../services/service_api.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final TextEditingController _searchController = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();

  List<UserFriendOrNot> _users = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      print("Text Controller Value: ${_searchController.text}");
      _searchSubject.add(_searchController.text);
    });

    _searchSubject.debounceTime(const Duration(milliseconds: 500)).listen((stringToSearch) async {
      if (stringToSearch.trim().isNotEmpty) {
      setState(() {
        _isSearching = true;
      });

      final result = await ServiceAPI().find_users_friend_or_not_by_string(stringToSearch,UserManager.currentUser!.token);
      if (result is Failure<List<UserFriendOrNot>, String>) {
        _showWrongCredentialsDialog(result.error);
      }
      setState(() {
        _isSearching = false;

        if (result is Success<List<UserFriendOrNot>, String>) {
          _users = result.value;
          _users = _users.where((user) => user.isFriend == false).toList();
        } else if (result is Failure<List<UserFriendOrNot>, String>) {
          _showWrongCredentialsDialog(result.error);
        }
      });
    }});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Rechercher un utilisateur',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: buildChildBasedOnSearchStatus(),
          ),
        ],
      ),
    );
  }

  Widget buildChildBasedOnSearchStatus() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.pseudo),
            trailing: buildActionButton(user),
          );
        },
      );
    }
  }

  Widget buildActionButton(UserFriendOrNot user) {
      return IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () async {
          await ServiceAPI().askFriend(UserManager.currentUser!.token, user.id);

          setState(() {
            _users.remove(user);
          });
        },
      );
  }

  void _showWrongCredentialsDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}