import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:river_makale/models/user.dart';

final userService = Provider((ref) => UserService());

class UserService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));

  Future<List<User>> getUsers() async {
    final res = await _dio.get('users');
    final List list = res.data['data'];
    list[0]['role'] = 'normal';
    list[1]['role'] = 'normal';
    list[2]['role'] = 'normal';
    list[3]['role'] = 'admin';
    list[4]['role'] = 'admin';
    list[5]['role'] = 'normal';
    return list.map((e) => User.fromJson(e)).toList();
  }
}
