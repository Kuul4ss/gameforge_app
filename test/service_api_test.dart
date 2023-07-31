
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameforge_app/models/entities/user.dart';
import 'package:gameforge_app/models/requests/login_request.dart';

import 'package:gameforge_app/services/service_api.dart';

void main() {
  test('Test de la méthode connection', () async {
    final serviceAPI api = serviceAPI();
    final dio = Dio();
    final loginRequest = LoginRequest(pseudo: 'lucas', password: 'password');

    final User? result = await api.connection(loginRequest);


    expect(result, isNotNull);

    dio.close();
  });
}