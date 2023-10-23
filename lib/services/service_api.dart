import 'package:dio/dio.dart';
import 'package:gameforge_app/models/either/either.dart';
import 'package:gameforge_app/models/requests/login_request.dart';

import '../models/entities/user_friend_or_not.dart';
import '../models/entities/user.dart';



class ServiceAPI{
  final String baseURL = "http://localhost:4000/gameforge-api";
  final String baseURLEmul = "http://172.29.80.1:4000/gameforge-api";
  final dio = Dio();

  Future<Either<User,String>> connection(LoginRequest loginRequest) async {
    try {
      final response = await dio.post(
          '$baseURLEmul/users/log', data: loginRequest.toJson());
      if (response.statusCode == 200) {
        return Success(User.fromJson(response.data));
      }else{
        return Failure('Unknown error');
      }
    }catch(e) {
      if (e is DioError && e.response?.statusCode == 400) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<List<User>, String>> get_friends(String user_token) async {
    try {
      final response = await dio.get(
        '$baseURLEmul/friends/$user_token',
      );
      if (response.statusCode == 200) {
        final List<User> friendsList = (response.data as List).map((data) => User.fromJson(data)).toList();
        return Success(friendsList);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<List<UserFriendOrNot>, String>> find_users_friend_or_not_by_string(String string_to_search, String user_token) async {
    try {
      final response = await dio.get(
          '$baseURLEmul/users/search/friend_or_not',
          queryParameters: {
            'string_to_search': string_to_search,
            'user_token': user_token,
          }
      );

      if (response.statusCode == 200) {
        final List<UserFriendOrNot> usersList = (response.data as List).map((data) => UserFriendOrNot.fromJson(data)).toList();
        return Success(usersList);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<void, String>> acceptFriend(String userId,String friendId) async {
    try {
      final response = await dio.patch('$baseURLEmul/friends/accept/$userId/$friendId');

      if (response.statusCode == 200) {
        return Success(null);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<void, String>> deleteFriend(String userToken,friendToken) async {
    try {
      final response = await dio.delete('$baseURLEmul/friends/delete/$userToken/$friendToken');

      if (response.statusCode == 200) {
        return Success(null);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }



  Future<Either<void, String>> askFriend(String userToken, String friendId) async {
    try {
      final response = await dio.post(
          '$baseURLEmul/friends',
          data: {
            'user_token': userToken,
            'friend_id': friendId
          }
      );

      if (response.statusCode == 201) {
        return Success(null);
      } else {
        return Failure('Erreur lors de la demande d\'ami');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<List<User>, String>> getSentRequests(String userToken) async {
    try {
      final response = await dio.get(
        '$baseURLEmul/friends/sent_requests/$userToken',
      );
      if (response.statusCode == 200) {
        final List<User> usersList = (response.data as List)
            .map((data) => User.fromJson(data))
            .toList();
        return Success(usersList);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

  Future<Either<List<User>, String>> getAskedRequests(String userToken) async {
    try {
      final response = await dio.get(
        '$baseURLEmul/friends/asked_requests/$userToken',
      );
      if (response.statusCode == 200) {
        final List<User> usersList = (response.data as List)
            .map((data) => User.fromJson(data))
            .toList();
        return Success(usersList);
      } else {
        return Failure('Unknown error');
      }
    } catch (e) {
      if (e is DioError) {
        return Failure(e.response?.data['message'] ?? 'Unknown error');
      }
      return Failure('Unknown error');
    }
  }

}