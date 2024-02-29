import 'package:dio/dio.dart';
import 'package:ihabits/repositories/interceptor_dio.dart';

class CustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    //_dio.options.baseUrl = 'http://10.0.2.2:3333/';
    _dio.options.baseUrl = 'http://192.168.15.69:3333/';
    _dio.interceptors.add(DioInterceptor());
  }
}