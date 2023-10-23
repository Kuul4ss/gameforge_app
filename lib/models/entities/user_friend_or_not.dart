import 'package:uuid/uuid.dart';

class UserFriendOrNot {
  final String id;
  final String email;
  final String pseudo;
  final bool isFriend;

  UserFriendOrNot({
    required this.id,
    required this.email,
    required this.pseudo,
    required this.isFriend,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "pseudo": pseudo,
        "isFriend": isFriend,
      };

  factory UserFriendOrNot.fromJson(Map<String, dynamic> json) {
    return UserFriendOrNot(
      id: json['id'],
      email: json['email'],
      pseudo: json['pseudo'],
      isFriend: json['isFriend'],
    );
  }
}