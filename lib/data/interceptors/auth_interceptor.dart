import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      "Content-Type": "application/json",
      "x-api-key":
          "live_JBT0Ah0Nt12iyl2IpjQVLDWjcLk0GQwf4zI9wBMfmfejKmcC31mOJp4y ",
    });
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Refresh the token if the request results with status code of 401.
      return handler.resolve(
        await dio.fetch(err.requestOptions),
      ); // Repeat the request.
    }

    return handler.reject(
      DioException(requestOptions: err.requestOptions, error: err.response),
    );
  }
}
