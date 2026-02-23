import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/todos/1",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
