import '../../../../core/network/api_client.dart';
import 'post_model.dart';

class PostRemoteDataSource {
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('/posts');

    return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
  }

  Future<PostModel> addPost(PostModel post) async {
    final response = await dio.post('/posts', data: post.toJson());

    return PostModel.fromJson(response.data);
  }

  Future<void> deletePost(int id) async {
    await dio.delete('/posts/$id');
  }
}
