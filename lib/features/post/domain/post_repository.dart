import 'package:cleanstructure/features/post/domain/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> addPost(Post post);
  Future<void> deletePost(int id);
}
