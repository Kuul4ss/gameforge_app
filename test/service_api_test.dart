
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameforge_app/models/either/either.dart';
import 'package:gameforge_app/models/entities/user.dart';
import 'package:gameforge_app/models/requests/login_request.dart';

import 'package:gameforge_app/services/service_api.dart';

void main() {
  test('Test de la méthode connection', () async {
    final ServiceAPI api = ServiceAPI();
    final dio = Dio();
    final loginRequest = LoginRequest(pseudo: 'lucas', password: 'password');

    final Either<User, String> result = await api.connection(loginRequest);


    expect(result is Success<User, String>, true);

    dio.close();
  });

  test('Test de la méthode askFriend', () async {

    final ServiceAPI api = ServiceAPI();
    const userToken = "0f5589ad-4f4f-4f64-a44f-8aeafd793e25";
    const friendId = "e434764a-556a-4139-9434-1d5172acd923";

    final result = await api.askFriend(userToken, friendId);

    expect(result is Success<void, String>, true);
  });

  test('Test de la méthode acceptFriend', () async {
    final ServiceAPI api = ServiceAPI();
    const String userId = "10bdd8d6-0ea7-4268-9835-45fdd4d60e01";
    const String friendId = "0f5589ad-4f4f-4f64-a44f-8aeafd793e25";

    final Either<void, String> result = await api.acceptFriend(userId,friendId);

    expect(result is Success<void, String>, true);
  });

  test('Test de la méthode get_friends', () async {
    final ServiceAPI api = ServiceAPI();
    const userToken = "0f5589ad-4f4f-4f64-a44f-8aeafd793e25";

    final Either<List<User>, String> result = await api.get_friends(userToken);

    expect(result is Success<List<User>, String>, true);
  });

  test('Test de la méthode deleteFriend', () async {
    final ServiceAPI api = ServiceAPI();
    const String userId = "10bdd8d6-0ea7-4268-9835-45fdd4d60e01";
    const String friendId = "0f5589ad-4f4f-4f64-a44f-8aeafd793e25";

    final Either<void, String> result = await api.deleteFriend(userId,friendId);

    expect(result is Success<void, String>, true);
  });

  test('Test de la méthode getSentRequests', () async {
    final ServiceAPI api = ServiceAPI();
    final dio = Dio();

    final Either<List<User>, String> result = await api.getSentRequests('0f5589ad-4f4f-4f64-a44f-8aeafd793e25');

    expect(result is Success<List<User>, String>, true);

    dio.close();
  });

  test('Test de la méthode getAskedRequests', () async {
    final ServiceAPI api = ServiceAPI();
    final dio = Dio();

    final Either<List<User>, String> result = await api.getAskedRequests('10bdd8d6-0ea7-4268-9835-45fdd4d60e01');

    expect(result is Success<List<User>, String>, true);

    dio.close();
  });
}