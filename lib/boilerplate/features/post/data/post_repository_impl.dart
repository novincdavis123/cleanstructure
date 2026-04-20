import 'package:cleanstructure/boilerplate/features/post/domain/post.dart';
import 'package:cleanstructure/boilerplate/features/post/domain/post_repository.dart';

import 'post_model.dart';
import 'post_remote_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remote;

  PostRepositoryImpl(this.remote);

  @override
  Future<List<Post>> getPosts() async {
    return await remote.getPosts();
  }

  @override
  Future<Post> addPost(Post post) async {
    final model = PostModel(id: post.id, title: post.title, body: post.body);

    return await remote.addPost(model);
  }

  @override
  Future<void> deletePost(int id) async {
    await remote.deletePost(id);
  }
}
