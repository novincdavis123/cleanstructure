import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    // Set a reasonable timeout for all requests
    connectTimeout: const Duration(seconds: 10),
    // Add headers to mimic a real browser request
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ),
);
