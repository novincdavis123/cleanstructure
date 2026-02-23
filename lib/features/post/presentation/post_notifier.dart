import 'package:cleanstructure/features/post/domain/post.dart';
import 'package:cleanstructure/features/post/domain/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/post_remote_datasource.dart';
import '../data/post_repository_impl.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(PostRemoteDataSource());
});

final postNotifierProvider = AsyncNotifierProvider<PostNotifier, List<Post>>(
  PostNotifier.new,
);

class PostNotifier extends AsyncNotifier<List<Post>> {
  PostRepository get repository => ref.read(postRepositoryProvider);

  @override
  Future<List<Post>> build() async {
    return repository.getPosts();
  }

  Future<void> addPost(String title, String body) async {
    final newPost = await repository.addPost(
      Post(id: 0, title: title, body: body),
    );

    state = AsyncData([...state.value ?? [], newPost]);
  }

  Future<void> deletePost(int id) async {
    await repository.deletePost(id);

    state = AsyncData(state.value!.where((post) => post.id != id).toList());
  }
}
