import '../../constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 10000, // 60 seconda
      receiveTimeout: 20 * 10000, //20 seconds
    );
    dio = Dio(options);
    print('DIO executed successfully');
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      print('getting response');
      Response response = await dio.get('/characters');
      print('///////////////////////////////////////');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getAllQuotes(String authorName) async {
    try {
      print('getting quotes');
      Response response = await dio.get(
        '/quotes',
        queryParameters: {'author': authorName},
      );
      print('///////////////////////////////////////');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
