import 'package:flutter/material.dart';
import 'package:gameforge_app/models/either/either.dart';
import 'package:gameforge_app/models/entities/user_manager.dart';
import 'package:gameforge_app/services/service_api.dart';
import '../models/entities/user.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({Key? key}) : super(key: key);

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late Future<Either<List<User>, String>> _pendingRequests;
  late Future<Either<List<User>, String>> _confirmedFriends;

  @override
  void initState() {
    super.initState();
    _pendingRequests = ServiceAPI().getSentRequests(UserManager.currentUser!.token);
    _confirmedFriends = ServiceAPI().get_friends(UserManager.currentUser!.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            buildFriendList("Demandes en attente", _pendingRequests),
            const SizedBox(height: 20),
            buildFriendList("Amis", _confirmedFriends),
          ],
        ),
      ),
    );
  }

  Widget buildFriendList(String title, Future<Either<List<User>, String>> futureList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        FutureBuilder<Either<List<User>, String>>(
          future: futureList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Text('Erreur lors du chargement des amis.');
            }

            final data = snapshot.data;
            if (data is Success<List<User>, String>) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.value.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final friend = data.value[index];
                  return ListTile(
                    title: Text(
                      friend.pseudo,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading: const Icon(Icons.people),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await ServiceAPI().deleteFriend(UserManager.currentUser!.token, friend.idFriend!);
                        setState(() {
                          data.value.remove(friend);
                        });
                      },
                    ),
                  );
                },
              );
            } else if (data is Failure<List<User>, String>) {
              return Center(child: Text(data.error));
            } else {
              return const Center(child: Text('Unknown error.'));
            }
          },
        ),
      ],
    );
  }
}
