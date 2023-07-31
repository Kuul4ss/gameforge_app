import '../../services/date_time_parser.dart';

class Message{
  String id;
  String senderId;
  String receiverId;
  String content;
  DateTime? sendDate;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sendDate

  });

  // Map<String, dynamic> toJson() =>
  //     {
  //       "email": email,
  //       "pseudo": pseudo,
  //       "token": token,
  //       "token_date": tokenDate
  //     };

  factory Message.fromJson(Map<String, dynamic> json) {
    DateTimeParser dateTimeParser = DateTimeParser();
    return Message(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      sendDate: dateTimeParser.parseDate(json['send_date']),
    );
  }
}