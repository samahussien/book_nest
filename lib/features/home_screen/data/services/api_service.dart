import 'package:book_nest/features/home_screen/data/services/api_paths.dart';
import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = ApiPaths.baseUrl;
  Dio dio;
  ApiService(this.dio);
  Future<Response> get({required String endPoint,    Map<String, dynamic>? queryParameters,
 }) async {
    var response = await dio.get("$_baseUrl$endPoint",queryParameters: queryParameters);
    return response;
  }
}
