import 'package:dio/dio.dart';
import 'package:gameforge_app/models/requests/login_request.dart';

import '../models/entities/user.dart';



class serviceAPI{
  final String baseURL = "http://localhost:4000/gameforge-api";
  final dio = Dio();

  Future<User?> connection(LoginRequest loginRequest) async {
    final response = await dio.post('$baseURL/users/log',data: loginRequest.toJson());
    if(response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      return null;
    }
  }


}