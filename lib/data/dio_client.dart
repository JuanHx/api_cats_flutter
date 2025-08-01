import 'package:dio/dio.dart';

import 'interceptors/auth_interceptor.dart';

class DioClient {
  static const String _baseUrl = "https://api.thecatapi.com/v1";

  DioClient() {
    addInterceptor(LogInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(AuthInterceptor(dio: dio));
    dio.interceptors.add(interceptor);
  }
}