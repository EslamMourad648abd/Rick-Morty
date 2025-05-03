import 'package:dio/dio.dart';
import 'package:untitled/constants/strings.dart';

//This code is hand written
class CharactersAPI {
  late Dio dio;

  CharactersAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(minutes: 2),
      receiveTimeout: Duration(minutes: 2),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

