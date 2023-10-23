import 'package:gameforge_app/services/date_time_parser.dart';


class User {
  String email;
  String pseudo;
  String token;
  DateTime tokenDate;
  String? idFriend;

  User({
    required this.email,
    required this.pseudo,
    required this.token,
    required this.tokenDate,
    this.idFriend
  });

  Map<String, dynamic> toJson() =>
      {
        "email": email,
        "pseudo": pseudo,
        "token": token,
        "token_date": tokenDate
      };

   factory User.fromJson(Map<String, dynamic> json) {
    DateTimeParser dateTimeParser = DateTimeParser();
    return User(
      email: json['email'],
      pseudo: json['pseudo'],
      token: json['token'],
      tokenDate:dateTimeParser.tokenParseDate(json['tokenDate']),
      idFriend: json['id']
    );
  }

}