import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_notifier.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: posts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final post = data[index];

            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(postNotifierProvider.notifier).deletePost(post.id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(postNotifierProvider.notifier)
              .addPost("New Title", "New Body");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
