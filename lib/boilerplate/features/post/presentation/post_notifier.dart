import 'package:cleanstructure/boilerplate/features/post/domain/post.dart';
import 'package:cleanstructure/boilerplate/features/post/domain/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/post_remote_datasource.dart';
import '../data/post_repository_impl.dart';

// Repository provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(PostRemoteDataSource());
});

// AsyncNotifier provider
final postNotifierProvider = AsyncNotifierProvider<PostNotifier, List<Post>>(
  () => PostNotifier(),
);

class PostNotifier extends AsyncNotifier<List<Post>> {
  PostRepository get repository => ref.read(postRepositoryProvider);

  @override
  Future<List<Post>> build() async {
    try {
      final posts = await repository.getPosts();
      return posts;
    } catch (e, st) {
      throw AsyncValue.error(e, st); // Properly throw error with stacktrace
    }
  }

  Future<void> addPost(String title, String body) async {
    try {
      final newPost = await repository.addPost(
        Post(id: 0, title: title, body: body),
      );
      state = AsyncData([...state.value ?? [], newPost]);
    } catch (e, st) {
      state = AsyncValue.error(e, st); // ✅ Fixed: 2 arguments
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await repository.deletePost(id);
      state = AsyncData(state.value!.where((post) => post.id != id).toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st); // ✅ Fixed
    }
  }
}
