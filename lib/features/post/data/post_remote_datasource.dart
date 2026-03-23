import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import 'post_model.dart';
import 'package:dio/dio.dart';

class PostRemoteDataSource {
  /// Fetch all posts from the API
  Future<List<PostModel>> getPosts() async {
    try {
      // Set a timeout to prevent infinite loading
      log('Requesting: ${dio.options.baseUrl}/posts');
      debugPrint('Request URL: ${dio.options.baseUrl}/posts');
      final response = await dio
          .get('/posts')
          .timeout(const Duration(seconds: 10));

      final data = response.data;

      // Ensure the response is a list
      if (data is List) {
        return data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected API response: $data');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch posts: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Add a new post
  Future<PostModel> addPost(PostModel post) async {
    try {
      final response = await dio
          .post('/posts', data: post.toJson())
          .timeout(const Duration(seconds: 10));
      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to add post: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Delete a post by ID
  Future<void> deletePost(int id) async {
    try {
      await dio.delete('/posts/$id').timeout(const Duration(seconds: 10));
    } on DioException catch (e) {
      throw Exception('Failed to delete post: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
